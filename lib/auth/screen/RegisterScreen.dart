import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_products_web/auth/auth.service.dart';
import 'package:flutter_products_web/common/contants.dart';
import 'package:flutter_products_web/common/widget/CustomField.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key, this.token = "", required this.setToken})
      : super(key: key);

  final String token;
  final ValueChanged<String> setToken;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmit(context) async {
    try {
      var name = nameController.text;
      var email = emailController.text;
      var password = passwordController.text;
      await AuthService().register(name, email, password);
      setToken("");
      Navigator.of(context).pushNamed('/login');
    } catch (e) {
      log(e.toString());
    }
  }

  void onLogin(context) async {
    Navigator.of(context).pushNamed('/login');
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: CustomTextField(
                        hintText: "Name", controller: nameController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: CustomTextField(
                        hintText: "Email", controller: emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: CustomPasswordField(
                        hintText: "Password", controller: passwordController),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            decoration: BoxDecoration(
                                border: GradientBoxBorder(
                                  gradient:
                                      LinearGradient(colors: gradientColors),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(24)),
                            child: OutlinedButton(
                              onPressed: () => onSubmit(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: GradientText(
                                  'Register',
                                  style: const TextStyle(
                                      fontSize: 24,
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
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            decoration: BoxDecoration(
                                border: GradientBoxBorder(
                                  gradient:
                                      LinearGradient(colors: gradientColors),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(24)),
                            child: OutlinedButton(
                              onPressed: () => onLogin(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: GradientText(
                                  'Go to login',
                                  style: const TextStyle(
                                      fontSize: 24,
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
