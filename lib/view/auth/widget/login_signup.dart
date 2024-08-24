// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model_view/auth_provider.dart';
import 'package:remindly/services/validators.dart';

class AuthCase extends StatefulWidget {
  final bool isLogin;
  final GlobalKey<FormState> formkey;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  TextEditingController nameController;
  AuthCase({
    super.key,
    required this.isLogin,
    required this.formkey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
  });

  @override
  State<AuthCase> createState() => _AuthCaseState();
}

class _AuthCaseState extends State<AuthCase> {
  //controllers

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Container(
          height: !widget.isLogin
              ? MediaQuery.of(context).size.height * 0.65
              : MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: const Color(0xff007AFF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Form(
              key: widget.formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.isLogin ? 'Login' : 'Signup',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!widget.isLogin)
                    //name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: widget.nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          fillColor: Color(0xffFFFFFF),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffC4C4C4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  //email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: widget.emailController,
                      validator: ValidateService.validateEmail,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffC4C4C4),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: widget.passwordController,
                      validator: ValidateService.validatePassword,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffC4C4C4),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: 'password',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!widget.isLogin)
                    //password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: widget.confirmPasswordController,
                        validator: (value) {
                          if (value != widget.passwordController.text) {
                            return 'Password does not match';
                          }
                          return ValidateService.validatePassword(value);
                        },
                        decoration: const InputDecoration(
                          fillColor: Color(0xffFFFFFF),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffC4C4C4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  //button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () async {
                        if (widget.formkey.currentState!.validate()) {
                          if (widget.isLogin) {
                            //show loading
                            loadingWidget(context);
                            await value.login(
                              widget.emailController.text,
                              widget.passwordController.text,
                            );
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          } else {
                            loadingWidget(context);
                            await value.register(
                              widget.nameController.text,
                              widget.emailController.text,
                              widget.passwordController.text,
                              'https://i.pinimg.com/564x/5a/93/18/5a9318fa42b8eff23f9c466d55916792.jpg',
                            );
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          }
                          if (value.error != null) {
                            ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                content: Text(value.error!),
                                backgroundColor: Colors.red[300],
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                    },
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (value.isLogin) {
                            Navigator.of(context).pushReplacementNamed('/menu');
                          }
                        }
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xff5F4BA3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
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
          ),
        ),
      ),
    );
  }
}
