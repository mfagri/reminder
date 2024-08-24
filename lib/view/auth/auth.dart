// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:remindly/view/auth/widget/login_signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF5F5F5),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Welcome to\n Remindly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthCase(
                isLogin: isLogin,
                formkey: formkey,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                nameController: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLogin = true;
                          formkey.currentState!.reset();
                          emailController.clear();
                          passwordController.clear();
                          confirmPasswordController.clear();
                          nameController.clear();
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color:
                              isLogin ? const Color(0xff5F4BA3) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'login',
                              style: TextStyle(
                                color: isLogin
                                    ? Colors.white
                                    : const Color(0xff5F4BA3),
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            isLogin = false;
                            formkey.currentState!.reset();
                            emailController.clear();
                            passwordController.clear();
                            confirmPasswordController.clear();
                            nameController.clear();
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color:
                              isLogin ? Colors.white : const Color(0xff5F4BA3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'signup',
                              style: TextStyle(
                                color: isLogin
                                    ? const Color(0xff5F4BA3)
                                    : Colors.white,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
