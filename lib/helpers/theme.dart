import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.whiteColor,
  fontFamily: 'Nunito',
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.whiteColor,
    elevation: 0,
    titleTextStyle: TextStyle(color: AppColors.blackColor),
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.blackColor),
    actionsIconTheme: IconThemeData(color: AppColors.blackColor),
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24),
    displayMedium: TextStyle(fontSize: 20),
    displaySmall: TextStyle(fontSize: 18),
    headlineMedium: TextStyle(fontSize: 16),
    headlineSmall: TextStyle(fontSize: 14),
    titleLarge: TextStyle(fontSize: 12),
    titleMedium: TextStyle(fontSize: 16),
    titleSmall: TextStyle(fontSize: 14),
    bodyLarge: TextStyle(fontSize: 16),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: 'Nunito',
  scaffoldBackgroundColor: AppColors.bgDarkColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.bgDarkColor,
    elevation: 0,
    titleTextStyle: TextStyle(color: AppColors.whiteColor),
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.whiteColor),
    actionsIconTheme: IconThemeData(color: AppColors.whiteColor),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24),
    displayMedium: TextStyle(fontSize: 20),
    displaySmall: TextStyle(fontSize: 18),
    headlineMedium: TextStyle(fontSize: 16),
    headlineSmall: TextStyle(fontSize: 14),
    titleLarge: TextStyle(fontSize: 12),
    titleMedium: TextStyle(fontSize: 16),
    titleSmall: TextStyle(fontSize: 14),
    bodyLarge: TextStyle(fontSize: 16),
    labelLarge: TextStyle(
      fontSize: 16,
      color: AppColors.subTitleColor,
    ),
  ),
);
