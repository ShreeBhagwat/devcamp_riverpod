import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/screens/splash_screen.dart';
import 'package:flutter_riverpod_1/extensions/build_context_extensions.dart';
import 'package:flutter_riverpod_1/models/products.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';

class ProductsDetailScreen extends ConsumerWidget {
  const ProductsDetailScreen({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(product.title!),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(product.images!.first),
            ),
            Text(product.description!),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(productsRepoProvider)
                        .addProductToCart(product: product)
                        .then((value) {
                      if (context.mounted) {
                        context.showSnackBar('Product added to cart');
                      }
                    }).catchError((e) {
                      if (context.mounted) {
                        context.showSnackBar('Error adding product to cart');
                      }
                    });
                  },
                  child: Text(' Add To Cart - \$ ${product.price.toString()}')),
            ),
          ],
        ),
      ),
    );
  }
}
