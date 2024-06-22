import 'package:flutter/material.dart';

abstract class L10n {
  static List<Locale> get all => const [
        Locale('en'),
        Locale('fr'),
      ];
}
