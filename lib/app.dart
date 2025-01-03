import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/utils/helper/helper.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    log.i('Application Started');
    log.d('Environment: ${const String.fromEnvironment('ENV')}');

    return OKToast(
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, __) {
          return MaterialApp.router(
            routerConfig: ref.watch(routerProvider),
            localizationsDelegates: L10n.instance.delegates,
            supportedLocales: L10n.instance.supportedLocales,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                  textScaler: TextScaler.noScaling,
                  alwaysUse24HourFormat: true,
                ),
                child: child!,
              );
            },
            title: Constants.appName,
            theme: getAppTheme(context, ref),
            darkTheme: themeDark(context),
            locale: Locale(ref.watch(settingsProvider).locale),
            themeMode: ref.watch(themeModeProvider),
          );
        },
      ),
    );
  }
}
