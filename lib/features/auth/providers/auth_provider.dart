import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/features.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<Login?> build() => const AsyncValue.data(null);

  Future<Either<Failure, Login>> login(LoginParams params) async {
    state = const AsyncValue.loading();

    final postLogin = ref.read(postLoginProvider);
    final result = await postLogin.call(params);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (login) {
        state = AsyncValue.data(login);
      },
    );

    return result;
  }

  Future<Either<Failure, Login>> refreshToken(String token) async {
    state = const AsyncValue.loading();

    final postRefreshToken = ref.read(postRefreshTokenProvider);
    final result =
        await postRefreshToken.call(RefreshTokenParams(token: token));

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (login) => AsyncValue.data(login),
    );

    return result;
  }

  Future<Either<Failure, void>> logout() async {
    state = const AsyncValue.loading();
    debugPrint('AuthNotifier: Starting logout process...');

    final postLogout = ref.read(postLogoutProvider);
    final result = await postLogout.call(NoParams());

    result.fold(
      (failure) {
        debugPrint('AuthNotifier: Logout failed - ${failure.message}');
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (_) {
        debugPrint('AuthNotifier: Logout successful');
        state = const AsyncValue.data(null);
      },
    );

    return result;
  }

  Future<Either<Failure, void>> updatePassword(
    String oldPassword,
    String newPassword,
  ) async {
    state = const AsyncValue.loading();

    final postUpdatePassword = ref.read(postUpdatePasswordProvider);
    final result = await postUpdatePassword.call(
      UpdatePasswordParams(
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),
    );

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );

    return result;
  }
}
