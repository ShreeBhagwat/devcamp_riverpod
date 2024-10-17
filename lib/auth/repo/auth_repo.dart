import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod_1/auth/firebase_constants.dart';
import 'package:flutter_riverpod_1/auth/model/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_repo.g.dart';

@Riverpod(keepAlive: true)
AuthRepo authRepo(AuthRepoRef ref) {
  return AuthRepo();
}

class AuthRepo {
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        // return user here
        return userCredential.user;
      } else {
        return Future.error('Failed to login');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        final user = userCredential.user;

        await addUsersDataToFirestore(email: email, uid: user!.uid);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addUsersDataToFirestore(
      {required String email, required String uid}) async {
    try {
      final AppUser appUser = AppUser(
          id: uid,
          email: email,
          name: 'Test User',
          isDeleted: false,
          photoUrl: '');
      FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(uid)
          .set(appUser.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

// final authRepoProvider = Provider((ref) => AuthRepo());
