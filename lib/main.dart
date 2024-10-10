import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/all_products_screen.dart';

void main() => runApp(
      ProviderScope(
        child: RiverpodEcomApp(),
      ),
    );

class RiverpodEcomApp extends MaterialApp {
  RiverpodEcomApp({super.key}) : super(home: AllProductsScreen());
}
