import 'package:flutter/material.dart';

class KnockSnackBar {
  static void showSnackBar(
      {required BuildContext context,
      required String content,
      required SnackBarType snackBarType}) {
    var snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: snackBarType == SnackBarType.error
            ? Colors.red
            : snackBarType == SnackBarType.warning
                ? Colors.yellow
                : Colors.green,
        content: Text(content));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

enum SnackBarType {
  error,
  warning,
  success,
}
