import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_task/view/config/theme.dart';
import 'package:test_task/view/screens/subscription_screen.dart';
import 'package:test_task/view_model/subscription_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
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
        title: 'Test Task',
        theme: AppThemes.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SubscriptionScreen(title: "Subscription"),
        },
      ),
    );
  }
}
