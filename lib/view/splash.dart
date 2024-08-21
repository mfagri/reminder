import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/services/supabase.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      bool isAuthenticated = SupaService.isUserAuthenticated();

      if (!isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/menu');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xff007AFF).withOpacity(0.5),
          image: const DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Remindy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Remindy ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? webid;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      await dotenv.load(fileName: ".env");
      setState(() {
        webid = dotenv.env['WEB_CLIENT_ID'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: SupaSocialsAuth(
                colored: true,
                nativeGoogleAuthConfig: NativeGoogleAuthConfig(
                  webClientId: webid,
                ),
                enableNativeAppleAuth: false,
                socialProviders: OAuthProvider.values,
                onSuccess: (session) {
                  Navigator.of(context).pushReplacementNamed('/menu');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
