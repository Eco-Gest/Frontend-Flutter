part of 'theme_settings_cubit.dart';

class ThemeSettingsState {
  final Brightness brightness;

  ThemeSettingsState({
    required this.brightness,
  });

  bool get isDarkMode => brightness == Brightness.dark;

  ThemeSettingsState copyWith({
    Brightness? brightness,
  }) {
    return ThemeSettingsState(
      brightness: brightness ?? this.brightness,
    );
  }
}
