import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/models/products.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';

final productsFutureProvider = FutureProvider<List<Products>>((ref) async {
  return await ref.watch(productsRepoProvider).getProducts();
});
