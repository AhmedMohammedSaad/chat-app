import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  // --- Dark Theme ---
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkThemeColors.primary,
      scaffoldBackgroundColor: AppColors.darkThemeColors.background,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.darkThemeColors.primary,
        primary: AppColors.darkThemeColors.primary,
        secondary: AppColors.darkThemeColors.secondary,
        surface: AppColors.darkThemeColors.surface,
        error: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkThemeColors.textPrimary),
        titleTextStyle: AppTextStyles.darkTextTheme.headerPrimary.copyWith(
          fontSize: 20,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkThemeColors.surface,
        hintStyle: AppTextStyles.darkTextTheme.labelText.copyWith(
          color: AppColors.darkThemeColors.textSecondary.withValues(alpha: 0.5),
        ),
        labelStyle: AppTextStyles.darkTextTheme.labelText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.darkThemeColors.primaryBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.darkThemeColors.primaryBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.darkThemeColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkThemeColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.darkTextTheme.textButtonPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
      iconTheme: IconThemeData(color: AppColors.darkThemeColors.primary),
      useMaterial3: true,
      extensions: [AppColors.darkThemeColors, AppTextStyles.darkTextTheme],
    );
  }

  // --- Light Theme ---
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.lightThemeColors.primary,
      scaffoldBackgroundColor: AppColors.lightThemeColors.background,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.lightThemeColors.primary,
        primary: AppColors.lightThemeColors.primary,
        secondary: AppColors.lightThemeColors.secondary,
        surface: AppColors.lightThemeColors.surface,
        error: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.lightThemeColors.textPrimary),
        titleTextStyle: AppTextStyles.lightTextTheme.headerPrimary.copyWith(
          fontSize: 20,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightThemeColors.surface,
        hintStyle: AppTextStyles.lightTextTheme.labelText.copyWith(
          color: AppColors.lightThemeColors.textSecondary.withValues(
            alpha: 0.5,
          ),
        ),
        labelStyle: AppTextStyles.lightTextTheme.labelText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.lightThemeColors.primaryBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.lightThemeColors.primaryBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.lightThemeColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightThemeColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.lightTextTheme.textButtonPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
      iconTheme: IconThemeData(color: AppColors.lightThemeColors.primary),
      useMaterial3: true,
      extensions: [AppColors.lightThemeColors, AppTextStyles.lightTextTheme],
    );
  }
}
