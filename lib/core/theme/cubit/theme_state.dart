import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Serialize state to JSON for HydratedBloc
  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.index};
  }

  /// Deserialize state from JSON for HydratedBloc
  factory ThemeState.fromJson(Map<String, dynamic> json) {
    final int index = json['themeMode'] as int? ?? ThemeMode.dark.index;
    return ThemeState(themeMode: ThemeMode.values[index]);
  }
}
