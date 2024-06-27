import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.label,
    this.onTap,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.textInputType,
    this.inputFormatters = const [],
  });

  final String label;
  final Function()? onTap;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType? textInputType;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
