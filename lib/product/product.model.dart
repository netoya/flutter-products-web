import 'package:flutter_products_web/auth/auth.model.dart';

class Product {
  final String id;
  final String name;
  final num price;
  final User owner;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.owner,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      owner: User.fromJson(json['owner']),
    );
  }
}
