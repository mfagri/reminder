import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/model_view/auth_provider.dart';
import 'package:remindly/services/local_storage.dart';

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
      await LocalStorage.getToken().then((value) async {
        if (value != null) {
          await Provider.of<AuthProvider>(context, listen: false).getProfile();
          if (mounted) {
            if (Provider.of<AuthProvider>(context, listen: false).isLogin ==
                false) {
              LocalStorage.removeToken();
              Navigator.pushReplacementNamed(context, '/auth');
            } else {
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/menu');
              }
            }
          }
        } else {
          LocalStorage.removeToken();
          Navigator.pushReplacementNamed(context, '/auth');
        }
      });
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

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String? webid;
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 0), () async {
//       await dotenv.load(fileName: ".env");
//       setState(() {
//         webid = dotenv.env['WEB_CLIENT_ID'];
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF2F2F2),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 150,
//             width: 150,
//             decoration: BoxDecoration(
//               image: const DecorationImage(
//                 image: NetworkImage(
//                     'https://i.pinimg.com/564x/c6/67/ea/c667ea8efad5a59c560b40e76d590104.jpg'),
//                 fit: BoxFit.fill,
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           //text
//           const Text(
//             'Welcome to Remindy',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Color(0xff1488CC),
//               fontSize: 30,
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: SupaSocialsAuth(
//                 colored: true,
//                 nativeGoogleAuthConfig: NativeGoogleAuthConfig(
//                   webClientId: webid,
//                 ),
//                 localization: const SupaSocialsAuthLocalization(
//                   oAuthButtonLabels: {
//                     OAuthProvider.google: 'Sign in with Google',
//                   },
//                 ),
//                 socialButtonVariant: SocialButtonVariant.iconAndText,
//                 enableNativeAppleAuth: false,
//                 socialProviders: const [
//                   OAuthProvider.google,
//                   OAuthProvider.apple,
//                 ],
//                 onSuccess: (session) {
//                   Navigator.of(context).pushReplacementNamed('/menu');
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
