import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/products/models/products.dart';
import 'package:flutter_riverpod_1/products/repos/products_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_future_provider.g.dart';

// for Auth repo 

// @Riverpod(keepAlive: true)
// AuthRepo authRepo(AuthRepoRef ref) {
//   return AuthRepo();
// }


// for Products repo

// @Riverpod(keepAlive: true)
// ProductsRepo productsRepo(ProductsRepoRef ref) {
//   return ProductsRepo(ref);
// }

// for Products future provider

@Riverpod(keepAlive: true)
Future<List<Products>> productsFuture(Ref ref, String id) {
  return ref.watch(productsRepoProvider).getProducts();
}
