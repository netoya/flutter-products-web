import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_products_web/auth/auth.service.dart';
import 'package:flutter_products_web/common/contants.dart';
import 'package:flutter_products_web/common/widget/CustomField.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, this.token = "", required this.setToken})
      : super(key: key);

  final String token;
  final ValueChanged<String> setToken;

  final emailController = TextEditingController(text: "asdf@asdf.com");
  final passwordController = TextEditingController(text: "asdf");

  void onSubmit(context) async {
    try {
      var email = emailController.text;
      var password = passwordController.text;
      var data = await AuthService().login(email, password);
      setToken(data["token"]);
      Navigator.of(context).pushNamed('/');
    } catch (e) {
      log(e.toString());
    }
  }

  void onRegister(context) async {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Card(
            margin: EdgeInsets.all(12),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: CustomTextField(
                        hintText: "Email", controller: emailController),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: CustomPasswordField(
                        hintText: "Password", controller: passwordController),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: GradientBoxBorder(
                                  gradient:
                                      LinearGradient(colors: gradientColors),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: OutlinedButton(
                              onPressed: () => onSubmit(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: GradientText(
                                  'Login',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  colors: gradientColors,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: GradientBoxBorder(
                                  gradient:
                                      LinearGradient(colors: gradientColors),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: OutlinedButton(
                              onPressed: () => onRegister(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: GradientText(
                                  'Register',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  colors: gradientColors,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
