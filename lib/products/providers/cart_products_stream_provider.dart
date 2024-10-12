import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/models/products.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';

final cartProductsStreamProvider = StreamProvider<List<Products>>((ref) async* {
  yield* ref.watch(productsRepoProvider).getCartProducts();
});
