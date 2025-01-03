import 'package:hive_flutter/hive_flutter.dart';

enum MainBoxKeys {
  refreshToken,
  authToken,
  tokenExpiry,
  fcm,
  language,
  theme,
  locale,
  isLogin,
}

mixin class MainBoxMixin {
  static late Box? mainBox;
  static const _boxName = 'resto_lite_app';

  static Future<void> initHive(String prefixBox) async {
    // Initialize hive (persistent database)
    await Hive.initFlutter();
    mainBox = await Hive.openBox("$prefixBox$_boxName");
  }

  Future<void> addData<T>(MainBoxKeys key, T value) async {
    await mainBox?.put(key.name, value);
  }

  Future<void> removeData(MainBoxKeys key) async {
    await mainBox?.delete(key.name);
  }

  T? getData<T>(MainBoxKeys key) {
    final value = mainBox?.get(key.name);
    return value == null ? null : value as T;
  }

  Stream<T?> watch<T>(MainBoxKeys key) {
    return mainBox!.watch(key: key.name).map((event) => event.value as T?);
  }

  Future<void> logoutBox() async {
    /// Clear the box
    await removeData(MainBoxKeys.isLogin);
    await removeData(MainBoxKeys.authToken);
    await removeData(MainBoxKeys.refreshToken);
  }
}
