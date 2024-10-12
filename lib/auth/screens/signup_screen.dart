import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/products/screen/all_products_screen.dart';
import 'package:flutter_riverpod_1/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod_1/extensions/build_context_extensions.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    ref
                        .read(authControllerProvider.notifier)
                        .signUpWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: 'Test User',
                        )
                        .then((value) {
                      if (context.mounted) {
                        context.goTo(AllProductsScreen(), replaceScreen: true);
                      }
                    });
                  },
                  child: ref.watch(authControllerProvider).isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Signup')),
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Alredy a user? login instead'))
            ],
          ),
        ),
      ),
    );
  }
}
