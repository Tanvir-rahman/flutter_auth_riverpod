import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/error/failure.dart';
import 'package:resto_lite/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:resto_lite/features/auth/domain/entities/login.dart';
import 'package:resto_lite/features/auth/domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final AuthLocalDatasource _authLocalDatasource;

  const TokenRepositoryImpl(this._authLocalDatasource);

  @override
  String? getAccessToken() => _authLocalDatasource.getAccessToken();

  @override
  Future<Either<Failure, String>> getRefreshToken() =>
      _authLocalDatasource.getRefreshToken();

  @override
  Future<Either<Failure, void>> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final login = Login(
      tokenType: 'Bearer',
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return _authLocalDatasource.saveAuthData(login);
  }

  @override
  Future<Either<Failure, void>> clearTokens() =>
      _authLocalDatasource.clearAuthData();
}
