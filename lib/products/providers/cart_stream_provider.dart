import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/products/models/products.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';

final cartStreamProvider = StreamProvider.autoDispose<List<Products>>((ref) {
  return ref.watch(productsRepoProvider).getCartProducts();
});
