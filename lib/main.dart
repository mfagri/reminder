import 'package:flutter/material.dart';
import 'package:myapp/view/menu/menu.dart';
import 'package:myapp/view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/menu': (context) => const MainPage(),
      },
      initialRoute: '/',
    );
  }
}
