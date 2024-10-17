import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/products/models/products.dart';
import 'package:flutter_riverpod_1/products/providers/cart_stream_provider.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Products>> cartItems = ref.watch(cartStreamProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        body: cartItems.when(data: (cartList) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartList[index].title.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartList[index].description.toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$ ${cartList[index].price}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        await ref
                            .read(productsRepoProvider)
                            .removeItemFromCart(id: cartList[index].id!);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: cartList.length);
        }, error: (err, stk) {
          return Center(
            child: Text('Error: $err'),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
