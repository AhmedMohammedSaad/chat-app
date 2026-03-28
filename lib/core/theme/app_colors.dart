import 'package:flutter/material.dart';
import 'theme_extension.dart';

class AppColors {
  AppColors._(); 

  // --- Dark Theme Palette ---
  static const AppColorsExtension darkThemeColors = AppColorsExtension(
    background: Color(0xFF0A0710),
    surface: Color(0xFF16132D),
    primary: Color(0xFF9D4EDD),
    secondary: Color(0xFFE2A0FF),
    accentBlue: Color(0xFF48CAE4),
    primaryGradient: LinearGradient(
      colors: [Color(0xFF7B2CBF), Color(0xFF48CAE4)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    msgGradientMe: LinearGradient(
      colors: [Color(0xFF9D4EDD), Color(0xFF7B2CBF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    textPrimary: Colors.white,
    textSecondary: Color(0xFFA5A9B4),
    textFieldFill: Color(0x33FFFFFF), // 20% white
    searchBg: Color(0xFF1C1833),
    searchItemBg: Color(0xFF2D2459),
    textButtonAction: Color(0xFFE2A0FF),
    textButtonWhite: Colors.white,
    primaryBorder: Color(0xFF9D4EDD),
    msgMe: Color(0xFF9D4EDD),
    msgOther: Color(0xFF1C1833),
    sendIcon: Color(0xFF48CAE4),
  );

  // --- Light Theme Palette ---
  static const AppColorsExtension lightThemeColors = AppColorsExtension(
    background: Color(0xFFF0F2F5),
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFF7B2CBF),
    secondary: Color(0xFF9D4EDD),
    accentBlue: Color(0xFF00B4D8),
    primaryGradient: LinearGradient(
      colors: [Color(0xFF7B2CBF), Color(0xFF00B4D8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    msgGradientMe: LinearGradient(
      colors: [Color(0xFF7B2CBF), Color(0xFF9D4EDD)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    textPrimary: Color(0xFF1D1B20),
    textSecondary: Color(0xFF6B6875),
    textFieldFill: Color(0x0C000000), // 5% black
    searchBg: Color(0xffE2E5EA),
    searchItemBg: Color(0xFFFFFFFF),
    textButtonAction: Color(0xFF7B2CBF),
    textButtonWhite: Colors.white,
    primaryBorder: Color(0xFF7B2CBF),
    msgMe: Color(0xFF7B2CBF),
    msgOther: Color(0xffE2E5EA),
    sendIcon: Color(0xFF00B4D8),
  );

  // For backward compatibility until refactored
  static const Color primary = Color(0xFF9D4EDD); 
  static const Color background = Color(0xFF0A0710);
  static const Color surface = Color(0xFF16132D); 
  static const Color secondary = Color(0xFFE2A0FF);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA5A9B4);
  static const Color primaryBorder = Color(0xFF9D4EDD);
  static const Color sendIcon = Color(0xFF48CAE4);
  static const Color msgMe = Color(0xFF9D4EDD);
  static const Color msgOther = Color(0xFF1C1833);
  static const Color textButtonWhite = Colors.white;
  static const Color textButtonAction = Color(0xFFE2A0FF);
  static const Color searchBg = Color(0xFF1C1833);
  static const Color textFieldFill = Color(0x33ffffff);
}
