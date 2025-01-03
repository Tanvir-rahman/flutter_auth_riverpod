import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resto_lite/core/core.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => false);

final themeModeProvider = Provider<ThemeMode>((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return isDarkMode ? ThemeMode.dark : ThemeMode.light;
});

// Theme provider that requires context should be used with Consumer/ConsumerWidget
ThemeData getAppTheme(BuildContext context, WidgetRef ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return isDarkMode ? themeDark(context) : themeLight(context);
}
