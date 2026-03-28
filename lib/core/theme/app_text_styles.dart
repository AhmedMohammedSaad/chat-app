import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'theme_extension.dart';

class AppTextStyles {
  AppTextStyles._(); 

  // --- Dark Text Styles ---
  static AppTextThemeExtension darkTextTheme = AppTextThemeExtension(
    headerPrimary: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: AppColors.darkThemeColors.textPrimary,
      letterSpacing: 1.2,
    ),
    headerSecondary: TextStyle(
      fontSize: 15,
      color: AppColors.darkThemeColors.textSecondary,
      height: 1.4,
    ),
    labelText: TextStyle(
      fontSize: 14,
      color: AppColors.darkThemeColors.textSecondary,
      fontWeight: FontWeight.w500,
    ),
    buttonText: TextStyle(
      fontSize: 16,
      color: AppColors.darkThemeColors.textButtonWhite,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
    ),
    textButtonPrimary: TextStyle(
      color: AppColors.darkThemeColors.textPrimary,
      fontSize: 14,
    ),
    textButtonAction: TextStyle(
      color: AppColors.darkThemeColors.textButtonAction,
      fontSize: 13,
    ),
    textWhite: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    chatTimeText: TextStyle(
      fontSize: 12,
      color: AppColors.darkThemeColors.textSecondary,
    ),
  );

  // --- Light Text Styles ---
  static AppTextThemeExtension lightTextTheme = AppTextThemeExtension(
    headerPrimary: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: AppColors.lightThemeColors.textPrimary,
      letterSpacing: 1.2,
    ),
    headerSecondary: TextStyle(
      fontSize: 15,
      color: AppColors.lightThemeColors.textSecondary,
      height: 1.4,
    ),
    labelText: TextStyle(
      fontSize: 14,
      color: AppColors.lightThemeColors.textSecondary,
      fontWeight: FontWeight.w500,
    ),
    buttonText: TextStyle(
      fontSize: 16,
      color: AppColors.lightThemeColors.textButtonWhite,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
    ),
    textButtonPrimary: TextStyle(
      color: AppColors.lightThemeColors.textPrimary,
      fontSize: 14,
    ),
    textButtonAction: TextStyle(
      color: AppColors.lightThemeColors.textButtonAction,
      fontSize: 13,
    ),
    textWhite: const TextStyle(
      color: Colors.white, // Used for buttons or me-messages where background is primary color
      fontWeight: FontWeight.w500,
    ),
    chatTimeText: TextStyle(
      fontSize: 12,
      color: AppColors.lightThemeColors.textSecondary,
    ),
  );

  // For backward compatibility until refactored
  static const TextStyle headerPrimary = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: 1.2,
  );
  static const TextStyle headerSecondary = TextStyle(
    fontSize: 15,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  static const TextStyle labelText = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textButtonPrimary = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
  );
  static const TextStyle textWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    color: AppColors.textButtonWhite,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
  );
  static const TextStyle textButtonAction = TextStyle(
    color: AppColors.textButtonAction,
    fontSize: 13,
  );
}
