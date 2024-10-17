import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/products/screens/all_products_screen.dart';
import 'package:flutter_riverpod_1/auth/provider/auth_provider.dart';
import 'package:flutter_riverpod_1/auth/screen/signup_screen.dart';
import 'package:flutter_riverpod_1/extensions/build_context_extensions.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.isAuthenticated) {
        context.goTo(AllProductsScreen(), replaceScreen: true);
      } else if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error login"),
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      return;
                    }
                    ref.read(authProvider.notifier).signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                  },
                  child: ref.read(authProvider).isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : const Text('Login')),
              TextButton(
                  onPressed: () {
                    context.goTo(SignupScreen());
                  },
                  child: const Text('New user? Signup instead'))
            ],
          ),
        ),
      ),
    );
  }
}
