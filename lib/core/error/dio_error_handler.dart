import 'package:dio/dio.dart';
import 'package:resto_lite/core/error/failure.dart';

extension DioErrorHandler on DioException {
  Failure toFailure() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.server('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        if (statusCode == 401) {
          return const Failure.authentication('Unauthorized');
        }
        return Failure.server(
          response?.data?['message'] as String? ?? 'Server error occurred',
        );
      case DioExceptionType.cancel:
        return const Failure.server('Request cancelled');
      case DioExceptionType.connectionError:
        return const Failure.server('No internet connection');
      case DioExceptionType.badCertificate:
        return const Failure.server('Bad certificate');
      case DioExceptionType.unknown:
        return Failure.server(message ?? 'Unknown error occurred');
    }
  }
}
