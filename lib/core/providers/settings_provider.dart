import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void setLocale(String locale) {
    state = state.copyWith(locale: locale);
  }
}

class SettingsState {
  final String locale;

  const SettingsState({
    this.locale = 'en',
  });

  SettingsState copyWith({
    String? locale,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
    );
  }
}
