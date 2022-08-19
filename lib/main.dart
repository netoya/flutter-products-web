import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter_products_web/auth/screen/LoginScreen.dart';
import 'package:flutter_products_web/auth/screen/RegisterScreen.dart';
import 'package:flutter_products_web/product/Screen/ProductEditScreen.dart';
import 'package:flutter_products_web/product/Screen/ProductFormScreen.dart';
import 'package:flutter_products_web/product/Screen/ProductsScreen.dart';

void main() => runApp(SignUpApp());

class SignUpApp extends StatefulWidget {
  @override
  _SignUpApp createState() => _SignUpApp();
}

class _SignUpApp extends State<SignUpApp> {
  String _token = "";

  void _setToken(String newValue) {
    log("==> $newValue");

    setState(() {
      _token = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(token: _token, setToken: _setToken),
        '/register': (context) =>
            RegisterScreen(token: _token, setToken: _setToken),
        '/': (context) => ProductsScreen(token: _token, setToken: _setToken),
        '/form': (context) =>
            ProductFormScreen(token: _token, setToken: _setToken),
        '/edit': (context) =>
            ProductEditScreen(token: _token, setToken: _setToken)
      },
    );
  }
}
