import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/screen/login_screen.dart';
import 'package:flutter_riverpod_1/products/screens/cart_screen.dart';
import 'package:flutter_riverpod_1/extensions/build_context_extensions.dart';
import 'package:flutter_riverpod_1/products/models/products.dart';
import 'package:flutter_riverpod_1/products/screens/products_detail_screen.dart';
import 'package:flutter_riverpod_1/products/providers/products_future_provider.dart';

class AllProductsScreen extends ConsumerWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Products>> products =
        ref.watch(productsFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        actions: [
          IconButton(
            onPressed: () {
              // Add logout Funtionality
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              context.goTo(const CartScreen());
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: products.when(data: (data) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context.goTo(ProductsDetailScreen(product: data[index]));
                },
                title: Text(data[index].title.toString()),
                subtitle: Text(data[index].description.toString()),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: data.length);
      }, error: (error, stk) {
        return Center(
          child: Text('Error: $error'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
