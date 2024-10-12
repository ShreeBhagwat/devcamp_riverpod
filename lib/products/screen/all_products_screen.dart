import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod_1/auth/screens/splash_screen.dart';
import 'package:flutter_riverpod_1/extensions/build_context_extensions.dart';
import 'package:flutter_riverpod_1/models/products.dart';
import 'package:flutter_riverpod_1/products/providers/products_future_provider.dart';
import 'package:flutter_riverpod_1/products/screen/cart_screen.dart';
import 'package:flutter_riverpod_1/products/screen/products_detail_screen.dart';

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
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
              context.goTo(const SplashScreen(), replaceScreen: true);
            },
          ),
          IconButton(
              onPressed: () {
                context.goTo(const CartScreen());
              },
              icon: const Icon(Icons.shopping_bag))
        ],
      ),
      body: products.when(data: (data) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].title.toString()),
                subtitle: Text(data[index].description.toString()),
                onTap: () {
                  context.goTo(ProductsDetailScreen(product: data[index]));
                },
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
