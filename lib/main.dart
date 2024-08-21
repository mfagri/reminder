import 'package:flutter/material.dart';
import 'package:myapp/view/friends/add_friends.dart';
import 'package:myapp/view/menu/menu.dart';
import 'package:myapp/view/splash.dart';
import 'package:myapp/view/task/create_task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //init supabase
  await dotenv.load(fileName: ".env");
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  // await dotenv.load(fileName: ".env")
  await Supabase.initialize(
    url: supabaseUrl!,
    anonKey: supabaseAnonKey!,
  );
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
        '/login': (context) => const LoginPage(),
      },
      initialRoute: '/',
    );
  }
}
