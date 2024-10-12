import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/auth/screens/splash_screen.dart';
import 'package:flutter_riverpod_1/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: RiverpodEcomApp(),
    ),
  );
}

class RiverpodEcomApp extends MaterialApp {
  RiverpodEcomApp({super.key}) : super(home: const SplashScreen());
}
