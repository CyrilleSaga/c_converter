import 'package:c_converter/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../locales/tr.dart';

class CInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const CInputField({super.key, this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w900,
      ),
      onChanged: onChanged,
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: tr(context).amount,
        hintStyle: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w400,
          color: AppColors.textMutedColor,
        ),
      ),
    );
  }
}
