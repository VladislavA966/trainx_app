import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileRouteContainerScreen extends StatelessWidget {
  const ProfileRouteContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AutoRouter());
  }
}

class AppTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppTextFormField({
    required this.labelText,
    required this.controller,
    this.validator,
    this.onChanged,
    this.inputAction,
    this.keyboardType,
    this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextFormField(
          keyboardType: keyboardType,
          textInputAction: inputAction,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          obscuringCharacter: '•',
          obscureText: obscureText ?? false,
          style: TextStyle(fontWeight: FontWeight.bold),
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
