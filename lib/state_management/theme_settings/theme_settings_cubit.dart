import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_settings_state.dart';

/// Toggles the theme between light and dark mode.
///
/// By default, the theme is set to light mode.
class ThemeSettingsCubit extends Cubit<ThemeSettingsState> {
  ThemeSettingsCubit()
      : super(ThemeSettingsState(brightness: Brightness.light));

  /// Toggles the theme between light and dark mode.
  void toggleTheme() {
    emit(state.copyWith(
      brightness: state.isDarkMode ? Brightness.light : Brightness.dark,
    ));
  }
}
