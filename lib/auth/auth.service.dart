import 'dart:convert';

import 'package:flutter_products_web/auth/auth.model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
        Uri.parse('https://nest-products-api.herokuapp.com/api/auth/login'),
        body: ({'email': email, 'password': password}));

    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var token = json["token"];
      var user = User.fromJson(json["user"]);

      return {"token": token, "user": user};
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json["message"].toString());
    }
  }

  Future<User> register(String name, String email, String password) async {
    final response = await http.post(
        Uri.parse('https://nest-products-api.herokuapp.com/api/auth/register'),
        body: ({'name': name, 'email': email, 'password': password}));

    var json = jsonDecode(response.body);
    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json["message"].toString());
    }
  }
}
