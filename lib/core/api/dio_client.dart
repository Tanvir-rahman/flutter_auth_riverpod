import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/auth/auth.dart';
import 'package:resto_lite/utils/utils.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient with MainBoxMixin, FirebaseCrashLogger {
  String baseUrl;

  bool _isUnitTest = false;
  late Dio _dio;
  late TokenRepository _tokenRepository;

  // ignore: prefer_const_constructors
  DioClient({
    String? baseUrl,
    bool isUnitTest = false,
    TokenRepository? tokenRepository,
  }) : baseUrl = baseUrl ?? const String.fromEnvironment("BASE_URL") {
    _isUnitTest = isUnitTest;
    _tokenRepository =
        tokenRepository ?? TokenRepositoryImpl(AuthLocalDatasourceImpl(this));
    _dio = _createDio();

    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor(_tokenRepository));
  }

  Dio get dio {
    if (_isUnitTest) {
      /// Return static dio if is unit test
      return _dio;
    } else {
      /// We need to recreate dio to avoid token issue after login
      final dio = _createDio();
      dio.interceptors.add(DioInterceptor(_tokenRepository));

      return dio;
    }
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Either<Failure, T>> _handleRequest<T>({
    required Future<Response> Function() requestFn,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await requestFn();
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e, stackTrace) {
      try {
        if (!_isUnitTest) {
          nonFatalError(error: e, stackTrace: stackTrace);
        }
        // TODO: Needs to update
        return Left(
          // ServerFailure(
          //   e.response?.data['diagnostic']['message'] as String? ?? e.message,
          // ),
          // Return error without diagonostic
          ServerFailure(e.response?.data['message'] as String? ?? e.message),
        );
      } catch (_) {
        return Left(ServerFailure(e.message ?? 'Unknown error'));
      }
    }
  }

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) async {
    return _handleRequest<T>(
      requestFn: () => dio.get(url, queryParameters: queryParameters),
      converter: converter,
      isIsolate: isIsolate,
    );
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) async {
    return _handleRequest<T>(
      requestFn: () => dio.post(url, data: data),
      converter: converter,
      isIsolate: isIsolate,
    );
  }
}
