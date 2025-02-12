import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'configs/app_startup.dart';
import 'generated/l10n.dart';
import 'shared/analytics/analytics_service.dart';
import 'shared/navigation/navigation_service.dart';
import 'root/route/route.dart';
import 'shared/navigation/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppStartUp().setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, child) => MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: '{{name.pascalCase()}}',
        themeMode: ThemeMode.light,
        // theme: lightTheme,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: GetIt.I<AnalyticService>().instance,
          ),
        ],
        navigatorKey: GetIt.I<NavigationService>().navigatorKey,
        initialRoute: RootRoutes.initial,
        onGenerateRoute: routes,
      ),
    );
  }
}
