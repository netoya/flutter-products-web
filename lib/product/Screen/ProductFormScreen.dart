import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_products_web/common/contants.dart';
import 'package:flutter_products_web/common/widget/CustomField.dart';
import 'package:flutter_products_web/product/product.model.dart';
import 'package:flutter_products_web/product/product.service.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({Key? key, this.token: "", required this.setToken})
      : super(key: key);

  final String token;
  final ValueChanged<String> setToken;

  @override
  _ProductFormScreen createState() => _ProductFormScreen();
}

class _ProductFormScreen extends State<ProductFormScreen> {
  late Future<List<Product>> productsFuture =
      ProductService.getProducts(widget.token);

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  void onSubmit(context) async {
    try {
      var name = nameController.text;
      var price = priceController.text;
      var data = await ProductService.createProduct(widget.token, name, price);
      Navigator.of(context).pushNamed('/');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.token == "") {
      Timer.run(() async {
        // import 'dart:async:
        Navigator.of(context).pushNamed('/login');
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Productos"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  widget.setToken("");
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: double.infinity,
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: CustomTextField(
                            hintText: "Name", controller: nameController),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: CustomNumberField(
                            hintText: "Price", controller: priceController),
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
                                      gradient: LinearGradient(
                                          colors: gradientColors),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: OutlinedButton(
                                  onPressed: () {
                                    onSubmit(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Text(
                                      'Create',
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
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
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      Navigator.of(context).pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text('Cancel'),
                                    ),
                                  ))),
                        ],
                      ),
                    ]),
              ))),
        ));
  }
}
