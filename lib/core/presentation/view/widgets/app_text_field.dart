import 'package:flutter/material.dart';
import '../../../theme/theme_extension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hint;

  const AppTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.hint = "",
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: textStyles.textButtonPrimary.copyWith(color: colors.textPrimary),
      cursorColor: colors.accentBlue,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textStyles.labelText,
        filled: true,
        fillColor: colors.textFieldFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.primaryBorder.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}
