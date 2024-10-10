import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/models/products.dart';
import 'package:flutter_riverpod_1/networking/api_endpoints.dart';
import 'package:flutter_riverpod_1/networking/dio_client.dart';

class ProductsRepo {
  final Ref ref;
  ProductsRepo(this.ref);

  Future<List<Products>> getProducts() async {
    final response =
        await ref.read(dioProvider).get(ApiEndpoints.GetProductsEndPoint);
    if (response.statusCode == 200) {
      List<Products> products =
          response.data['products'].map<Products>((product) {
        return Products.fromJson(product);
      }).toList();
      return products;
    } else {
      return Future.error('failed to load prodcuts');
    }
  }
}

final productsRepoProvider = Provider((ref) => ProductsRepo(ref));
