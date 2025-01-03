import 'package:flutter/material.dart';
import 'package:resto_lite/core/widgets/app_header.dart';
import 'package:resto_lite/core/widgets/bottom_nav_bar.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onNavTap;

  const AuthLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }
}
