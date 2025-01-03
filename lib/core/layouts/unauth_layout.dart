import 'package:flutter/material.dart';

class UnAuthLayout extends StatelessWidget {
  final Widget child;

  const UnAuthLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
