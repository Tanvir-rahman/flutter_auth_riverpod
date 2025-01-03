import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:resto_lite/utils/utils.dart';

mixin FirebaseServices {
  static Future<void> init() async {
    // TODO: Enable Firebase initialization when configuration is ready
    debugPrint('Firebase services temporarily disabled');
    /*
    /// Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Pass all uncaught errors from the framework to Crashlytics.
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    /// Catch errors that happen outside of the Flutter context,
    Isolate.current.addErrorListener(
      RawReceivePort((List<dynamic> pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last as StackTrace,
        );
      }).sendPort,
    );
    */
  }
}
