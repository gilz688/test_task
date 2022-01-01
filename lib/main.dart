import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';
import 'package:test_task/view/config/theme.dart';
import 'package:test_task/view/screens/subscription_screen.dart';
import 'package:test_task/view_model/subscription_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('en'),
          Locale('de'),
        ],
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SubscriptionViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: tr('app_name'),

        //themes
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,

        // localization settings
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        // routes
        initialRoute: '/',
        routes: {
          '/': (context) =>
              SubscriptionScreen(title: tr('subscription_screen_title')),
        },
      ),
    );
  }
}
