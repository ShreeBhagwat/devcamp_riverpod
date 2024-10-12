import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void goTo(Widget screen, {bool? replaceScreen = false}) {
    if (replaceScreen!) {
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen), (route) => false);
    } else {
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
    }
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
