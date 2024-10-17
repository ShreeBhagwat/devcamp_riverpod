import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/products/models/products.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';

class ProductsDetailScreen extends ConsumerWidget {
  const ProductsDetailScreen({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(product.images!.first.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.description.toString()),
            ),
            ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(productsRepoProvider)
                      .addProductToCart(product: product)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Product Added to cart')));
                  }).catchError((e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error: $e')));
                  });
                },
                child: Text('Add to cart \$ ${product.price}')),
          ],
        ),
      ),
    );
  }
}
