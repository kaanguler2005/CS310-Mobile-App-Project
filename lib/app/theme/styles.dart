import 'package:flutter/material.dart';

import 'colors.dart';
import 'spacing.dart';

ThemeData buildStudyTrackTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: AppColors.text,
    onSurfaceVariant: AppColors.mutedText,
    error: AppColors.error,
  );
  const radius = BorderRadius.all(Radius.circular(AppSpacing.controlRadius));
  const fieldBorder = OutlineInputBorder(
    borderRadius: radius,
    borderSide: BorderSide(color: AppColors.fieldBorder),
  );
  const buttonShape = RoundedRectangleBorder(borderRadius: radius);
  const buttonSize = Size.fromHeight(AppSpacing.controlHeight);
  const buttonText = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    fontFamily: 'Noto Sans',
    inputDecorationTheme: const InputDecorationThemeData(
      filled: true,
      errorMaxLines: 3,
      fillColor: AppColors.fieldFill,
      hintStyle: TextStyle(color: AppColors.mutedText),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.small,
      ),
      constraints: BoxConstraints(minHeight: AppSpacing.controlHeight),
      border: fieldBorder,
      enabledBorder: fieldBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: buttonSize,
        shape: buttonShape,
        textStyle: buttonText,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: buttonSize,
        side: BorderSide(color: scheme.primary),
        shape: buttonShape,
        textStyle: buttonText,
      ),
    ),
  );
}
