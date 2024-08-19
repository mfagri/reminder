import 'package:flutter/material.dart';
import 'package:myapp/view/friends/add_friends.dart';
import 'package:myapp/view/menu/menu.dart';
import 'package:myapp/view/splash.dart';
import 'package:myapp/view/task/create_task.dart';

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
        '/addfriends': (context) => const AddFriends(),
        '/createtask': (context) => const CreateTask(),
      },
      initialRoute: '/',
    );
  }
}
