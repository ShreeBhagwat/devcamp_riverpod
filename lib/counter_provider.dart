import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterProvider extends StateNotifier<int> {
  CounterProvider() : super(0);

  void increament() {
    state++;
  }

  void decreament() {
    state--;
  }
}

final counterProvider =
    StateNotifierProvider<CounterProvider, int>((ref) => CounterProvider());
