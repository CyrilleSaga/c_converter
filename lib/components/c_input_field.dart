import 'package:c_converter/helpers/constants.dart';
import 'package:flutter/material.dart';

class CInputField extends StatelessWidget {
  final Function(String)? onChanged;

  const CInputField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w900,
      ),
      onChanged: onChanged,
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppColors.primaryColor,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Enter amount",
        hintStyle: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w400,
          color: AppColors.textMutedColor,
        ),
      ),
    );
  }
}
