import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_products_web/product/product.model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<Product>> getProducts(String token) async {
    if (token.isEmpty) {
      return [];
    }

    final response = await http.get(
        Uri.parse('https://nest-products-api.herokuapp.com/api/product/'),
        headers: {"Authorization": "Bearer $token"});

    log("===>>");
    var json = jsonDecode(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      // If the server did return a 204 OK response,
      // then parse the JSON.

      List<Product> products = [];

      for (var product in json) {
        products.add(Product.fromJson(product));
      }

      return products;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json.toString());
    }
  }

  static Future<Product> createProduct(String token, name, price) async {
    final response = await http.post(
      Uri.parse('https://nest-products-api.herokuapp.com/api/product/'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode({"name": name, "price": double.parse(price)}),
    );

    log("===>>");
    var json = jsonDecode(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      // If the server did return a 204 OK response,
      // then parse the JSON.

      return Product.fromJson(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json.toString());
    }
  }

  static Future<Product> getProduct(String token, id) async {
    final response = await http.get(
        Uri.parse('https://nest-products-api.herokuapp.com/api/product/{$id}'),
        headers: {"Authorization": "Bearer $token"});

    log("===>>");
    var json = jsonDecode(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      // If the server did return a 204 OK response,
      // then parse the JSON.

      return Product.fromJson(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json.toString());
    }
  }

  static Future<Product> updateProduct(String token, id, name, price) async {
    final response = await http.put(
      Uri.parse('https://nest-products-api.herokuapp.com/api/product/${id}'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode({"name": name, "price": double.parse(price)}),
    );

    log("===>>");
    var json = jsonDecode(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      // If the server did return a 204 OK response,
      // then parse the JSON.

      return Product.fromJson(json["product"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json.toString());
    }
  }

  static Future<Product> deleteProducts(String token, id) async {
    final response = await http.delete(
      Uri.parse('https://nest-products-api.herokuapp.com/api/product/${id}'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    log("===>>");
    var json = jsonDecode(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      // If the server did return a 204 OK response,
      // then parse the JSON.

      return Product.fromJson(json["product"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(json.toString());
    }
  }
}
