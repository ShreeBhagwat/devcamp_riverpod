import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  void goTo(Widget screen, {bool replaceScreen = false}) {
    if (replaceScreen) {
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen), (route) => false);
    } else {
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
    }
  }

  void goBack() {
    Navigator.of(this).pop();
  }
}
