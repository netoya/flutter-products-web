import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_products_web/common/contants.dart';
import 'package:flutter_products_web/product/product.model.dart';
import 'package:flutter_products_web/product/product.service.dart';
import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat.simpleCurrency();

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key, this.token: "", required this.setToken})
      : super(key: key);

  final String token;
  final ValueChanged<String> setToken;

  @override
  _ProductsScreen createState() => _ProductsScreen();
}

class _ProductsScreen extends State<ProductsScreen> {
  late Future<List<Product>> productsFuture =
      ProductService.getProducts(widget.token);

  void onEdit(Product product) {
    log(product.name.toString());
    Navigator.of(context).pushNamed('/edit', arguments: product);
  }

  void onDelete(Product product) async {
    await ProductService.deleteProducts(widget.token, product.id);
    // ignore: use_build_context_synchronously
    Navigator.of(context).popAndPushNamed('/');
    // productsFuture = ProductService.getProducts(widget.token);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/form');
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
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
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: productsFuture,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      List<Product> products = snapshot.data;

                      return ListView.separated(
                        separatorBuilder: ((context, index) {
                          return const SizedBox(
                            height: 10.0,
                            width: double.infinity,
                          );
                        }),
                        itemCount: products.length,
                        itemBuilder: ((context, index) {
                          Product product = products[index];
                          return Card(
                            // onPressed: () {
                            //   Navigator.of(context)
                            //       .pushNamed('/edit', arguments: product);
                            // },
                            child: ListTile(
                              title: Text(product.name),
                              subtitle: Text(formatCurrency
                                  .format(product.price)
                                  .toString()),
                              trailing: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == "edit") {
                                    onEdit(product);
                                  }
                                  if (value == "delete") {
                                    onDelete(product);
                                  }
                                },
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem(
                                        value: "edit", child: Text("Edit")),
                                    const PopupMenuItem(
                                        value: "delete",
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ];
                                },
                              ),
                            ),
                          );
                        }),
                      );
                    } else {
                      return const Text("No user data");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
