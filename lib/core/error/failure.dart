import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:resto_lite/core/error/dio_error_handler.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server([String? message]) = ServerFailure;
  const factory Failure.network([String? message]) = NetworkFailure;
  const factory Failure.cache([String? message]) = CacheFailure;
  const factory Failure.validation([String? message]) = ValidationFailure;
  const factory Failure.authentication([String? message]) = AuthenticationFailure;
  const factory Failure.noData([String? message]) = NoDataFailure;

  static Failure fromDioError(DioException error) => error.toFailure();
}
