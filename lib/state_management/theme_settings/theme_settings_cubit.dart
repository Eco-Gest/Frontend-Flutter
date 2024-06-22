import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_settings_state.dart';

/// Toggles the theme between light and dark mode.
/// By default, the theme is set to light mode.

class ThemeSettingsCubit extends Cubit<ThemeSettingsState> {
  ThemeSettingsCubit() : super(ThemeSettingsState(themeMode: ThemeMode.light)) {
    _loadTheme();
  }

  static const String _themePrefKey = 'isDarkMode';

  /// Toggles the theme between light and dark mode.
  void toggleTheme() {
    final newThemeMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: newThemeMode));
    _saveTheme(newThemeMode);
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefKey, themeMode == ThemeMode.dark);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themePrefKey) ?? false;
    emit(state.copyWith(
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }
}
