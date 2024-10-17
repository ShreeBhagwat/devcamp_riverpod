import 'dart:developer';
import 'package:flutter_riverpod_1/auth/repo/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_provider.g.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

extension AuthStatusX on AuthStatus {
  bool get isLoading => this == AuthStatus.loading;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isError => this == AuthStatus.error;
}

// final authProvider =
//     NotifierProvider<AuthProvider, AuthStatus>(() => AuthProvider());

@Riverpod()
class Auth extends _$Auth {
  @override
  AuthStatus build() {
    return AuthStatus.initial;
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    state = AuthStatus.loading;
    try {
      final user = await ref
          .read(authRepoProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        state = AuthStatus.authenticated;
      } else {
        state = AuthStatus.unauthenticated;
      }
    } catch (e) {
      log(e.toString());
      state = AuthStatus.error;
    }
  }

  Future createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    state = AuthStatus.loading;
    try {
      final user = await ref
          .read(authRepoProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        state = AuthStatus.authenticated;
      }
    } catch (e) {
      log(e.toString());
      state = AuthStatus.error;
    }
  }
}
