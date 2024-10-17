import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/products/screens/all_products_screen.dart';
import 'package:flutter_riverpod_1/auth/screen/login_screen.dart';
import 'package:flutter_riverpod_1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: RiverpodEcomApp(),
    ),
  );
}

class RiverpodEcomApp extends MaterialApp {
  RiverpodEcomApp({super.key}) : super(home: LoginScreen());
}
