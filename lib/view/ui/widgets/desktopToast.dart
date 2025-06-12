import 'package:flutter/material.dart';

class Desktoptoast {
  
  void showDesktopToast(BuildContext context, String message, {bool error = false}) {
    final color = error ? Colors.red : Colors.green;
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}