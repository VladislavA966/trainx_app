import 'package:flutter/material.dart';
import '../recources/app_colors.dart';

class AppTypography {
  static const TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Josefin Sans',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: AppColors.white,
    ),
  );
}
