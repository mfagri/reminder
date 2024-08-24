import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/model_view/auth_provider.dart';
import 'package:remindly/model_view/friend_provider.dart';
import 'package:remindly/model_view/task_provider.dart';
import 'package:remindly/view/auth/auth.dart';
import 'package:remindly/view/friends/add_friends.dart';
import 'package:remindly/view/menu/menu.dart';
import 'package:remindly/view/splash.dart';
import 'package:remindly/view/task/create_task.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //init supabase
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => FriendProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/menu': (context) => const MainPage(),
          '/addfriends': (context) => const AddFriends(),
          '/createtask': (context) => const CreateTask(),
          // '/login': (context) => const LoginPage(),
          '/auth': (context) => const AuthPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
