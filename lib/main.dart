import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resto_lite/app.dart';
import 'package:resto_lite/dependencies_injection.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// Register Service locator
      await initializeServices();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(
        const ProviderScope(
          child: App(),
        ),
      );
    },
    (error, stackTrace) async {
      // TODO: Enable Firebase Crashlytics when configuration is ready
      debugPrint('Error: $error\nStackTrace: $stackTrace');
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
