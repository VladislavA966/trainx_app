import 'package:flutter/material.dart';

class AppKeyboardDismissWrapper extends StatelessWidget {
  final Widget child;

  const AppKeyboardDismissWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
