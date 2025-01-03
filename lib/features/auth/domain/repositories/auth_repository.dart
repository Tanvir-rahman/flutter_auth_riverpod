import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/auth/auth.dart';

abstract class AuthRepository {
  bool get isAuthenticated;

  Stream<bool> get authStateStream;

  Future<Either<Failure, Login>> login(LoginParams params);

  Future<Either<Failure, String>> logout();

  Future<Either<Failure, Login>> refreshToken(RefreshTokenParams refreshToken);

  Future<Either<Failure, void>> updatePassword(UpdatePasswordParams params);
}
