import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
import 'package:trainx_app/core/recources/dimensions.dart';

class AppComponentsTheme {
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.greyDark,
    iconTheme: const IconThemeData(color: AppColors.primary),
    titleTextStyle: const TextStyle(
      fontFamily: 'Josefin Sans',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
  );

  static BottomNavigationBarThemeData bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.greyDark,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.greyLight,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.unit4),
      ),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static BottomSheetThemeData bottomSheetTheme = const BottomSheetThemeData(
    backgroundColor: AppColors.greyDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(Dimensions.unit2),
      ),
    ),
  );

  static IconThemeData iconDataTheme =
      const IconThemeData(color: AppColors.primary);

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.greyDark,
    labelStyle: TextStyle(color: AppColors.greyLight),
    suffixIconColor: AppColors.greyLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.unit2),
    ),
  );
}
