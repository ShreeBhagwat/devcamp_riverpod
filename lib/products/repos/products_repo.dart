import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/firebase_constants.dart';
import 'package:flutter_riverpod_1/products/models/products.dart';
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

  Future addProductToCart({required Products product}) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(user.uid)
          .collection(FirebaseConstants.cartCollection)
          .add(product.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Products>> getCartProducts() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(user.uid)
          .collection(FirebaseConstants.cartCollection)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Products.fromJson(doc.data());
        }).toList();
      });
    } else {
      return Stream.error('Error fetching cart items');
    }
  }

  Future removeItemFromCart({required int id}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(user.uid)
          .collection(FirebaseConstants.cartCollection)
          .where('id', isEqualTo: id)
          .get();
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }
  }
}

final productsRepoProvider = Provider((ref) => ProductsRepo(ref));
