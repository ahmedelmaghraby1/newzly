import 'package:flutter/material.dart';
import 'package:newzly/core/constants/fonts.dart';
import 'package:newzly/core/theme/theming_assets/colors.dart';
import 'package:newzly/core/theme/theming_assets/styles.dart';

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    dialogTheme: DialogTheme(backgroundColor: AppColors.white),
    appBarTheme: AppBarTheme(centerTitle: true),
    tabBarTheme: TabBarThemeData(
      dividerHeight: 0,
      tabAlignment: TabAlignment.center,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
        side: BorderSide(width: 1, color: AppColors.grey),
      ),
      contentTextStyle: AppTextStyles.darkBodyLarge,
      showCloseIcon: true,
    ),
    fontFamily: FontAssets.poppins,
    iconTheme: const IconThemeData(color: AppColors.purpple, size: 30),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white, // Light grey for Scaffold

    textTheme: const TextTheme(
      titleLarge: AppTextStyles.lightTitle,
      bodyLarge: AppTextStyles.lightBodyLarge, // Default Text color black
      bodyMedium: AppTextStyles.lightBodyMedium,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.lightHintStyle,
      border: AppBorders.border,
      errorBorder: AppBorders.errorBorder,
      focusedErrorBorder: AppBorders.errorBorder,
      enabledBorder: AppBorders.border,
      focusedBorder: AppBorders.border,
      disabledBorder: AppBorders.border,
      filled: false,
    ),
    colorScheme: const ColorScheme.light(
      error: AppColors.red,
      inversePrimary: AppColors.white,
      primary: AppColors.purpple,
      secondary: AppColors.transparent,
      tertiary: AppColors.backgroundColor,
      surface: AppColors.transparent,
      onPrimaryContainer: AppColors.backgroundColor,
      onSecondaryContainer: AppColors.white,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    dialogTheme: DialogTheme(backgroundColor: AppColors.grey),
    appBarTheme: AppBarTheme(centerTitle: true),
    tabBarTheme: TabBarThemeData(
      dividerHeight: 0,
      tabAlignment: TabAlignment.center,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey,
      contentTextStyle: AppTextStyles.darkBodyLarge,
      showCloseIcon: true,
    ),
    fontFamily: FontAssets.poppins,
    iconTheme: const IconThemeData(color: AppColors.white, size: 30),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBlack,
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.darkTitle,
      bodyLarge: AppTextStyles.darkBodyLarge, // Default Text color black
      bodyMedium: AppTextStyles.darkBodyMedium,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.darkHintStyle,
      border: AppBorders.border,
      errorBorder: AppBorders.errorBorder,
      focusedErrorBorder: AppBorders.errorBorder,
      enabledBorder: AppBorders.border,
      focusedBorder: AppBorders.border,
      disabledBorder: AppBorders.border,
      filled: true,
      fillColor: AppColors.grey,
    ),
    colorScheme: const ColorScheme.dark(
      error: AppColors.red,
      inversePrimary: AppColors.scaffoldBlack,
      primary: AppColors.white,
      secondary: AppColors.grey,
      tertiary: AppColors.transparent,
      surface: AppColors.transparent,
      onPrimaryContainer: AppColors.grey,
      onSecondaryContainer: AppColors.grey,
    ),
  );
}
