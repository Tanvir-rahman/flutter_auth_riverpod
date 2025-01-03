import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;
  final AuthLocalDatasource _authLocalDatasource;
  final TokenRepository _tokenRepository;

  const AuthRepositoryImpl(
    this._authRemoteDatasource,
    this._authLocalDatasource,
    this._tokenRepository,
  );

  @override
  bool get isAuthenticated => _authLocalDatasource.isAuthenticated;

  @override
  Stream<bool> get authStateStream => _authLocalDatasource.authStateStream;

  @override
  Future<Either<Failure, Login>> login(LoginParams params) async {
    final response = await _authRemoteDatasource.login(params);

    return response.fold(
      (failure) => Left(failure),
      (loginResponse) async {
        final login = loginResponse.toEntity();

        if (login.accessToken == null || login.refreshToken == null) {
          return const Left(AuthenticationFailure('Invalid token response'));
        }

        final result = await _tokenRepository.saveTokens(
          accessToken: login.accessToken!,
          refreshToken: login.refreshToken!,
        );

        return result.fold(
          (failure) => Left(failure),
          (_) => Right(login),
        );
      },
    );
  }

  @override
  Future<Either<Failure, String>> logout() async {
    final result = await _authRemoteDatasource.logout();

    return result.fold(
      (failure) => Left(failure),
      (_) async {
        final clearResult = await _tokenRepository.clearTokens();
        return clearResult.fold(
          (failure) => Left(failure),
          (_) => const Right('Logged out successfully'),
        );
      },
    );
  }

  @override
  Future<Either<Failure, Login>> refreshToken(
    RefreshTokenParams refreshToken,
  ) async {
    final response = await _authRemoteDatasource.refreshToken(refreshToken);

    return response.fold(
      (failure) => Left(failure),
      (loginResponse) async {
        final login = loginResponse.toEntity();

        if (login.accessToken == null || login.refreshToken == null) {
          return const Left(AuthenticationFailure('Invalid token response'));
        }

        final saveResult = await _tokenRepository.saveTokens(
          accessToken: login.accessToken!,
          refreshToken: login.refreshToken!,
        );

        return saveResult.fold(
          (failure) => Left(failure),
          (_) => Right(login),
        );
      },
    );
  }

  @override
  Future<Either<Failure, void>> updatePassword(UpdatePasswordParams params) {
    return _authRemoteDatasource.updatePassword(params);
  }
}
