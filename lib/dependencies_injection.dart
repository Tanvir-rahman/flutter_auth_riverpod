import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/auth/auth.dart';
import 'package:resto_lite/utils/utils.dart';

/// Hive Storage
final mainBoxProvider = Provider<MainBoxMixin>((ref) => MainBoxMixin());

/// Auth Local Datasource
final authLocalDatasourceProvider = Provider<AuthLocalDatasource>((ref) {
  return AuthLocalDatasourceImpl(ref.watch(mainBoxProvider));
});

/// Token Repository
final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  return TokenRepositoryImpl(ref.watch(authLocalDatasourceProvider));
});

/// Auth Remote Client
final authRemoteClientProvider = Provider<AuthRemoteClient>((ref) {
  return AuthRemoteClient(ref.watch(dioProvider));
});

/// Auth Remote Datasource
final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(ref.watch(authRemoteClientProvider));
});

/// Auth Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDatasourceProvider),
    ref.watch(authLocalDatasourceProvider),
    ref.watch(tokenRepositoryProvider),
  );
});

/// Dio Client
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(tokenRepository: ref.watch(tokenRepositoryProvider));
});

/// Initialize required services
Future<void> initializeServices({
  bool isUnitTest = false,
  bool isHiveEnable = true,
}) async {
  if (!isUnitTest) {
    // TODO: Enable Firebase when configuration is ready
    // await firebase_core.Firebase.initializeApp();
    if (isHiveEnable) {
      await MainBoxMixin.initHive('');
    }
  }
}
