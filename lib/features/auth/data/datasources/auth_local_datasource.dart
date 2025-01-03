import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/error/failure.dart';
import 'package:resto_lite/features/auth/domain/entities/login.dart';
import 'package:resto_lite/utils/services/hive/hive.dart';

abstract interface class AuthLocalDatasource {
  bool get isAuthenticated;
  Stream<bool> get authStateStream;
  Future<Either<Failure, void>> saveAuthData(Login login);
  Future<Either<Failure, void>> clearAuthData();
  String? getAccessToken();
  Future<Either<Failure, String>> getRefreshToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final MainBoxMixin _mainBoxMixin;

  const AuthLocalDatasourceImpl(this._mainBoxMixin);

  @override
  bool get isAuthenticated {
    return _mainBoxMixin.getData<bool>(MainBoxKeys.isLogin) ?? false;
  }

  @override
  Stream<bool> get authStateStream =>
      _mainBoxMixin.watch<bool>(MainBoxKeys.isLogin).map((event) => event ?? false);

  @override
  Future<Either<Failure, void>> saveAuthData(Login login) async {
    try {
      await Future.wait([
        _mainBoxMixin.addData(MainBoxKeys.isLogin, true),
        _mainBoxMixin.addData(
          MainBoxKeys.authToken,
          "${login.tokenType} ${login.accessToken}",
        ),
        _mainBoxMixin.addData(MainBoxKeys.refreshToken, login.refreshToken),
        if (login.expiresIn != null)
          _mainBoxMixin.addData(
            MainBoxKeys.tokenExpiry,
            DateTime.now().add(Duration(seconds: login.expiresIn!)).toIso8601String(),
          ),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearAuthData() async {
    try {
      await Future.wait([
        _mainBoxMixin.removeData(MainBoxKeys.isLogin),
        _mainBoxMixin.removeData(MainBoxKeys.authToken),
        _mainBoxMixin.removeData(MainBoxKeys.refreshToken),
        _mainBoxMixin.removeData(MainBoxKeys.tokenExpiry),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  String? getAccessToken() {
    try {
      final token = _mainBoxMixin.getData(MainBoxKeys.authToken);
      return token?.toString();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Either<Failure, String>> getRefreshToken() async {
    try {
      final token = _mainBoxMixin.getData(MainBoxKeys.refreshToken);
      if (token == null) {
        return const Left(CacheFailure('Refresh token not found'));
      }
      return Right(token.toString());
    } catch (e) {
      return const Left(CacheFailure('Failed to get refresh token'));
    }
  }
}
