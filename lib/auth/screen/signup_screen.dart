import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/provider/auth_provider.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                    ref
                        .read(authProvider.notifier)
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                  },
                  child: ref.watch(authProvider).isLoading
                      ? const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Sign Up')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('have account? Login instead'))
            ],
          ),
        ),
      ),
    );
  }
}
