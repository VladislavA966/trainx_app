import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
import 'package:trainx_app/core/theme/app_fonts_theme.dart';
import 'package:trainx_app/core/theme/app_widgets_theme.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.greyDark,
      canvasColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.black,
      colorScheme: const ColorScheme.light(primary: AppColors.primary),
      fontFamily: 'Inter',
      appBarTheme: AppComponentsTheme.appBarTheme,
      textTheme: AppTypography.lightTextTheme,
      bottomNavigationBarTheme: AppComponentsTheme.bottomNavigationBarTheme,
      elevatedButtonTheme: AppComponentsTheme.elevatedButtonTheme,
      bottomSheetTheme: AppComponentsTheme.bottomSheetTheme,
      iconTheme: AppComponentsTheme.iconDataTheme,
      inputDecorationTheme: AppComponentsTheme.inputDecorationTheme,
    );
  }
}
