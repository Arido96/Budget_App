import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.label,
    this.onTap,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
  });

  final String label;
  final Function()? onTap;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
