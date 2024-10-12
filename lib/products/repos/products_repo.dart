import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod_1/firebase/firebase_providers.dart';
import 'package:flutter_riverpod_1/models/products.dart';
import 'package:flutter_riverpod_1/networking/api_endpoints.dart';
import 'package:flutter_riverpod_1/networking/dio_client.dart';
import 'package:flutter_riverpod_1/utlis/firebase_constants.dart';

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

  Future addProductToCart({required Products product}) async {
    try {
      final user = ref.read(userProvider);
      if (user != null) {
        ref
            .read(firestoreProvider)
            .collection('users')
            .doc(user.id)
            .collection(FirebaseConstants.cartCollection)
            .add(product.toJson());
      }
    } catch (e) {
      throw 'failed to add product to cart $e';
    }
  }

  Stream<List<Products>> getCartProducts() {
    final user = ref.read(userProvider);
    if (user != null) {
      return ref
          .read(firestoreProvider)
          .collection('users')
          .doc(user.id)
          .collection(FirebaseConstants.cartCollection)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Products.fromJson(doc.data());
        }).toList();
      });
    } else {
      return Stream.error('error fetching cart products');
    }
  }

  Future<void> removeProductFromCart({required Products product}) async {
    final user = ref.read(userProvider);
    if (user != null) {
      final snapshot = await ref
          .read(firestoreProvider)
          .collection('users')
          .doc(user.id)
          .collection(FirebaseConstants.cartCollection)
          .where('id', isEqualTo: product.id)
          .get();
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }
  }
}

final productsRepoProvider = Provider((ref) => ProductsRepo(ref));
