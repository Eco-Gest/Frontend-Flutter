part of 'theme_settings_cubit.dart';

class ThemeSettingsState {
  final ThemeMode themeMode;

  ThemeSettingsState({
    required this.themeMode,
  });

  bool get isDarkMode => themeMode == ThemeMode.dark;

  ThemeSettingsState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeSettingsState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
