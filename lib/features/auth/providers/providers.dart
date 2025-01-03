import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/features.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AuthLocalDatasource authLocalDatasource(Ref ref) {
  final mainBox = ref.read(mainBoxMixinProvider);
  return AuthLocalDatasourceImpl(mainBox);
}

/// Token Repository Provider
final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  final authLocalDatasource = ref.read(authLocalDatasourceProvider);
  return TokenRepositoryImpl(authLocalDatasource);
});

@riverpod
AuthRemoteClient authRemoteClient(Ref ref) {
  final dioClient = ref.watch(dioProvider);
  return AuthRemoteClient(dioClient);
}

@riverpod
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  final authClient = ref.read(authRemoteClientProvider);
  return AuthRemoteDatasourceImpl(authClient);
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final authRemoteDatasource = ref.read(authRemoteDatasourceProvider);
  final authLocalDatasource = ref.read(authLocalDatasourceProvider);
  final tokenRepository = ref.read(tokenRepositoryProvider);
  return AuthRepositoryImpl(
    authRemoteDatasource,
    authLocalDatasource,
    tokenRepository,
  );
}

@riverpod
PostLogin postLogin(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return PostLogin(authRepository);
}

@riverpod
PostRefreshToken postRefreshToken(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return PostRefreshToken(authRepository);
}

@riverpod
PostLogout postLogout(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return PostLogout(authRepository);
}

@riverpod
PostUpdatePassword postUpdatePassword(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return PostUpdatePassword(authRepository);
}
