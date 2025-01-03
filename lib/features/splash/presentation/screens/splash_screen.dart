import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:resto_lite/core/routes/routes.dart';
import 'package:resto_lite/features/splash/presentation/providers/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      final result = await ref.read(userLoginCheckProvider.future);
      if (!mounted) return;

      result.fold(
        (failure) => context.go(AppRoute.login.path),
        (isUserLoggedIn) => context.go(
          isUserLoggedIn ? AppRoute.root.path : AppRoute.login.path,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }
}
