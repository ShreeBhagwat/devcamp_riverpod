import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/model/app_user.dart';
import 'package:flutter_riverpod_1/firebase/firebase_providers.dart';

import '../../utlis/firebase_constants.dart';

final authRepoProvider = Provider(
    (ref) => AuthRepo(ref.read(authProvider), ref.read(firestoreProvider)));

class AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepo(this._firebaseAuth, this._firestore);

  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception("Failed to sign in.");
      } else {
        final userModel = await getCurrentUser();
        log("User signed in: $userModel");
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      log('Error signing in: ${e.code}');
      throw Exception(e.message ?? 'Something went wrong.');
    } catch (e) {
      log("Error signing in with Google: $e");
      return null;
    }
  }

  Future<AppUser?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception("User not logged in.");
      } else {
        final userDoc = await _firestore
            .collection(FirebaseConstants.usersCollection)
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          return AppUser.fromMap(userDoc.data()!);
        } else {
          throw Exception("User not found.");
        }
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Something went wrong.');
    } catch (e) {
      log("Error signing in with Google: $e");
      return null;
    }
  }

  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;
    final id = user!.uid;

    await _firestore
        .collection(FirebaseConstants.usersCollection)
        .doc(id)
        .update({"isDeleted": true});

    await user.delete();
  }

  Future<AppUser?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception("Failed to create user.");
      } else {
        final user = userCredential.user!;

        // Create user model
        final userModel = AppUser(
          id: user.uid,
          email: email,
          name: name,
          photoUrl: "",
          isDeleted: false,
        );

        await updateUser(userModel);

        log("User created: $userModel");

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Something went wrong.');
    } catch (e) {
      log("Error signing in with Google: $e");
      return null;
    }
  }

  Future<bool> updateUser(AppUser user) async {
    try {
      await _firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(user.id)
          .set(user.toMap());

      return true;
    } catch (e) {
      log("Error updating user: $e");
      return false;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
