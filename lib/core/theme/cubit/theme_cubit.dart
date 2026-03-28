import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // Start with light mode or match system
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.dark));

  void toggleTheme() {
    if (state.themeMode == ThemeMode.dark) {
      emit(const ThemeState(themeMode: ThemeMode.light));
    } else {
      emit(const ThemeState(themeMode: ThemeMode.dark));
    }
  }

  void setTheme(ThemeMode mode) {
    emit(ThemeState(themeMode: mode));
  }
}
