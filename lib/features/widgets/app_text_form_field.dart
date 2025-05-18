import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final void Function()? onTap;
  final bool readOnly;

  const AppTextFormField({
    required this.labelText,
    required this.controller,
    this.validator,
    this.onChanged,
    this.inputAction,
    this.keyboardType,
    this.obscureText,
    this.inputFormatter,
    this.onTap,
    this.readOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: keyboardType,
          textInputAction: inputAction,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          obscuringCharacter: '•',
          obscureText: obscureText ?? false,
          style: TextStyle(fontWeight: FontWeight.bold),
          inputFormatters: inputFormatter,
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    onPressed: () => controller.clear(),
                    icon: Icon(Icons.clear),
                  ),
          ),
        );
      },
    );
  }
}
