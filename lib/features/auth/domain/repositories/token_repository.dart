import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/error/failure.dart';

abstract interface class TokenRepository {
  String? getAccessToken();
  Future<Either<Failure, String>> getRefreshToken();
  Future<Either<Failure, void>> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  Future<Either<Failure, void>> clearTokens();
}
