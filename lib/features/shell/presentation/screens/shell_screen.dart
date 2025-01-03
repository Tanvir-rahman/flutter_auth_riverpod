import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resto_lite/core/layouts/auth_layout.dart';

class ShellScreen extends StatelessWidget {
  final StatefulNavigationShell child;

  const ShellScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      currentIndex: child.currentIndex,
      onNavTap: child.goBranch,
      child: child,
    );
  }
}

class ShellRouterScreen extends StatelessWidget {
  final Widget child;

  const ShellRouterScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
