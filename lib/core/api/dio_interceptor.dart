import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:resto_lite/features/auth/auth.dart';
import 'package:resto_lite/utils/utils.dart';

// coverage:ignore-start
class DioInterceptor extends Interceptor with FirebaseCrashLogger {
  final TokenRepository _tokenRepository;

  DioInterceptor(this._tokenRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = "";
    options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    // Add token to request headers
    final token = _tokenRepository.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    try {
      options.queryParameters.forEach(
        (k, v) => debugPrint(
          '► $k: $v',
        ),
      );
    } catch (_) {}
    try {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      final String prettyJson = encoder.convert(options.data);
      log.d(
        "REQUEST ► ︎ ${options.method.toUpperCase()} ${options.baseUrl}${options.path}\n\n"
        "Headers:\n"
        "$headerMessage\n"
        "❖ QueryParameters : \n"
        "Body: $prettyJson",
      );
    } catch (e, stackTrace) {
      log.e("Failed to extract json request $e");
      nonFatalError(error: e, stackTrace: stackTrace);
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException dioException,
    ErrorInterceptorHandler handler,
  ) async {
    log.e(
      "<-- ${dioException.message} ${dioException.response?.requestOptions != null ? (dioException.response!.requestOptions.baseUrl + dioException.response!.requestOptions.path) : 'URL'}\n\n"
      "${dioException.response?.data ?? 'Unknown Error'}",
    );

    // TODO: Unauthorized error code
    // Handle unauthorized errors (typically 401)
    if (dioException.response?.statusCode == 401) {
      try {
        // Attempt to refresh tokens
        final refreshResult = await _tokenRepository.getRefreshToken();

        await refreshResult.fold(
          (failure) async {
            // If refresh fails, clear tokens and handle logout
            await _tokenRepository.clearTokens();
            handler.next(dioException);
          },
          (_) async {
            // If refresh succeeds, retry the original request
            final options = dioException.requestOptions;
            final token = _tokenRepository.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            final response = await Dio().fetch(options);
            handler.resolve(response);
          },
        );
      } catch (e) {
        // If any unexpected error occurs during refresh
        _tokenRepository.clearTokens();
        handler.next(dioException);
      }
    } else {
      nonFatalError(error: dioException, stackTrace: dioException.stackTrace);
      handler.next(dioException);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    log.d(
      "◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Response: $prettyJson",
    );
    super.onResponse(response, handler);
  }
}
// coverage:ignore-end
