import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
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

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}
