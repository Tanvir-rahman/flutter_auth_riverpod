import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/error/failure.dart';
import 'package:resto_lite/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_provider.g.dart';

@riverpod
class UserLoginCheck extends _$UserLoginCheck {
  @override
  Future<Either<Failure, bool>> build() async {
    try {
      final authRepo = ref.watch(authRepositoryProvider);
      final isAuthenticated = authRepo.isAuthenticated;
      return Right(isAuthenticated);
    } catch (e) {
      return const Left(Failure.authentication());
    }
  }
}
