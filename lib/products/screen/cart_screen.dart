import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/models/products.dart';
import 'package:flutter_riverpod_1/products/providers/cart_products_stream_provider.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Products>> cartDate =
        ref.watch(cartProductsStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartDate.when(data: (cartList) {
        return cartList.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(cartList[index].images!.first),
                    title: Text(cartList[index].title.toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartList[index].description.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Price: \$ ${cartList[index].price.toString()}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(productsRepoProvider)
                            .removeProductFromCart(product: cartList[index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cartList.length)
            : const Center(
                child: Text('Cart is empty'),
              );
      }, error: (err, stk) {
        return Center(
          child: Text('Error: $err'),
        );
      }, loading: () {
        return const Center(
          child: const CircularProgressIndicator(),
        );
      }),
    );
  }
}
