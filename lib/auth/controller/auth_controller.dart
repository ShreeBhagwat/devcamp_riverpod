import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/model/app_user.dart';
import 'package:flutter_riverpod_1/auth/repo/auth_repo.dart';
import 'package:flutter_riverpod_1/firebase/firebase_providers.dart';

enum AuthState {
  loading,
  initial,
  authenticated,
  unauthenticated,
  error,
}

extension AuthStateX on AuthState {
  bool get isLoading => this == AuthState.loading;
  bool get isInitial => this == AuthState.initial;
  bool get isAuthenticated => this == AuthState.authenticated;
  bool get isUnauthenticated => this == AuthState.unauthenticated;
  bool get isError => this == AuthState.error;
}

final userProvider = StateProvider<AppUser?>((ref) => null);

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  () => AuthController(),
);

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState.initial;
  }

  Future<AppUser?> getCurrentUser() async {
    state = AuthState.loading;
    try {
      final user = await ref.read(authRepoProvider).getCurrentUser();
      if (user != null) {
        state = AuthState.authenticated;
        return user;
      } else {
        state = AuthState.unauthenticated;
        return null;
      }
    } catch (e) {
      state = AuthState.error;
      return null;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading;
    try {
      final user = await ref.read(authRepoProvider).signInWithEmailAndPassword(
            email: email,
            password: password,
          );

      if (user != null) {
        ref.read(userProvider.notifier).update((state) => user);

        state = AuthState.authenticated;
      }
    } catch (e) {
      log("Error signing in: $e");
      state = AuthState.error;
    }
  }

  Future<void> signOut() async {
    state = AuthState.loading;
    try {
      await ref.read(authRepoProvider).signOut();
      ref.read(userProvider.notifier).update((state) => null);
      state = AuthState.unauthenticated;
    } catch (e) {
      log("Error signing out: $e");
      state = AuthState.error;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      state = AuthState.loading;
      final user =
          await ref.read(authRepoProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
                name: name,
              );

      if (user != null) {
        ref.read(userProvider.notifier).update((state) => user);

        state = AuthState.authenticated;
      } else {
        throw Exception('Failed to sign up');
      }
    } catch (e) {
      log("Error signing up: $e");
      state = AuthState.error;
    }
  }
}
