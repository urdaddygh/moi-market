import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({super.key, this.hintText, this.controller, this.onChanged, this.keyboardType, this.suffixIcon, this.obscureText = false, this.validator});
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Style.textFormFieldStyle,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon
      ),
      // decoration: Style.formFieldDecoration.copyWith(hintText: hintText, suffixIcon: suffixIcon),
    );
  }
}
