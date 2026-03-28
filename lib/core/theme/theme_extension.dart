import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.background,
    required this.surface,
    required this.primary,
    required this.secondary,
    required this.accentBlue,
    required this.primaryGradient,
    required this.msgGradientMe,
    required this.textPrimary,
    required this.textSecondary,
    required this.textFieldFill,
    required this.searchBg,
    required this.searchItemBg,
    required this.textButtonAction,
    required this.textButtonWhite,
    required this.primaryBorder,
    required this.msgMe,
    required this.msgOther,
    required this.sendIcon,
  });

  final Color background;
  final Color surface;
  final Color primary;
  final Color secondary;
  final Color accentBlue;
  final LinearGradient primaryGradient;
  final LinearGradient msgGradientMe;
  final Color textPrimary;
  final Color textSecondary;
  final Color textFieldFill;
  final Color searchBg;
  final Color searchItemBg;
  final Color textButtonAction;
  final Color textButtonWhite;
  final Color primaryBorder;
  final Color msgMe;
  final Color msgOther;
  final Color sendIcon;

  @override
  AppColorsExtension copyWith({
    Color? background,
    Color? surface,
    Color? primary,
    Color? secondary,
    Color? accentBlue,
    LinearGradient? primaryGradient,
    LinearGradient? msgGradientMe,
    Color? textPrimary,
    Color? textSecondary,
    Color? textFieldFill,
    Color? searchBg,
    Color? searchItemBg,
    Color? textButtonAction,
    Color? textButtonWhite,
    Color? primaryBorder,
    Color? msgMe,
    Color? msgOther,
    Color? sendIcon,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accentBlue: accentBlue ?? this.accentBlue,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      msgGradientMe: msgGradientMe ?? this.msgGradientMe,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textFieldFill: textFieldFill ?? this.textFieldFill,
      searchBg: searchBg ?? this.searchBg,
      searchItemBg: searchItemBg ?? this.searchItemBg,
      textButtonAction: textButtonAction ?? this.textButtonAction,
      textButtonWhite: textButtonWhite ?? this.textButtonWhite,
      primaryBorder: primaryBorder ?? this.primaryBorder,
      msgMe: msgMe ?? this.msgMe,
      msgOther: msgOther ?? this.msgOther,
      sendIcon: sendIcon ?? this.sendIcon,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accentBlue: Color.lerp(accentBlue, other.accentBlue, t)!,
      primaryGradient: LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
      msgGradientMe: LinearGradient.lerp(msgGradientMe, other.msgGradientMe, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textFieldFill: Color.lerp(textFieldFill, other.textFieldFill, t)!,
      searchBg: Color.lerp(searchBg, other.searchBg, t)!,
      searchItemBg: Color.lerp(searchItemBg, other.searchItemBg, t)!,
      textButtonAction: Color.lerp(textButtonAction, other.textButtonAction, t)!,
      textButtonWhite: Color.lerp(textButtonWhite, other.textButtonWhite, t)!,
      primaryBorder: Color.lerp(primaryBorder, other.primaryBorder, t)!,
      msgMe: Color.lerp(msgMe, other.msgMe, t)!,
      msgOther: Color.lerp(msgOther, other.msgOther, t)!,
      sendIcon: Color.lerp(sendIcon, other.sendIcon, t)!,
    );
  }
}

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  const AppTextThemeExtension({
    required this.headerPrimary,
    required this.headerSecondary,
    required this.labelText,
    required this.buttonText,
    required this.textButtonPrimary,
    required this.textButtonAction,
    required this.textWhite,
    required this.chatTimeText,
  });

  final TextStyle headerPrimary;
  final TextStyle headerSecondary;
  final TextStyle labelText;
  final TextStyle buttonText;
  final TextStyle textButtonPrimary;
  final TextStyle textButtonAction;
  final TextStyle textWhite;
  final TextStyle chatTimeText;

  @override
  AppTextThemeExtension copyWith({
    TextStyle? headerPrimary,
    TextStyle? headerSecondary,
    TextStyle? labelText,
    TextStyle? buttonText,
    TextStyle? textButtonPrimary,
    TextStyle? textButtonAction,
    TextStyle? textWhite,
    TextStyle? chatTimeText,
  }) {
    return AppTextThemeExtension(
      headerPrimary: headerPrimary ?? this.headerPrimary,
      headerSecondary: headerSecondary ?? this.headerSecondary,
      labelText: labelText ?? this.labelText,
      buttonText: buttonText ?? this.buttonText,
      textButtonPrimary: textButtonPrimary ?? this.textButtonPrimary,
      textButtonAction: textButtonAction ?? this.textButtonAction,
      textWhite: textWhite ?? this.textWhite,
      chatTimeText: chatTimeText ?? this.chatTimeText,
    );
  }

  @override
  AppTextThemeExtension lerp(ThemeExtension<AppTextThemeExtension>? other, double t) {
    if (other is! AppTextThemeExtension) {
      return this;
    }
    return AppTextThemeExtension(
      headerPrimary: TextStyle.lerp(headerPrimary, other.headerPrimary, t)!,
      headerSecondary: TextStyle.lerp(headerSecondary, other.headerSecondary, t)!,
      labelText: TextStyle.lerp(labelText, other.labelText, t)!,
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t)!,
      textButtonPrimary: TextStyle.lerp(textButtonPrimary, other.textButtonPrimary, t)!,
      textButtonAction: TextStyle.lerp(textButtonAction, other.textButtonAction, t)!,
      textWhite: TextStyle.lerp(textWhite, other.textWhite, t)!,
      chatTimeText: TextStyle.lerp(chatTimeText, other.chatTimeText, t)!,
    );
  }
}

extension ThemeExt on BuildContext {
  AppColorsExtension get colors => Theme.of(this).extension<AppColorsExtension>()!;
  AppTextThemeExtension get textStyles => Theme.of(this).extension<AppTextThemeExtension>()!;
}
