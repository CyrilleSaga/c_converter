import 'package:flutter/material.dart';

abstract class AppConstants {
  static const String appName = 'C Converter';
  static const double defaultPadding = 16.0;
  static const String fontFamily = "Nunito";
  static const String apiKey = "3d30bb5c7f397f18de96ba96";
  static const String apiUrl = "https://v6.exchangerate-api.com/v6";
}

abstract class AppColors {
  static const Color primaryColor = Color(0xFFff6757);
  static const Color bgDarkColor = Color(0xFF121212);
  static const Color textMutedColor = Color(0xFF545454);
  static const Color whiteColor = Color(0xFFffffff);
  static const Color blackColor = Color(0xFF000000);
  static const Color subTitleColor = Color(0xFFEAE3E1);
}
