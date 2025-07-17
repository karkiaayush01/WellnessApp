import 'package:flutter/material.dart';

enum PopupType { error, success, warning, info }

class Popup {
  static void show(
      BuildContext context,
      String message, {
        PopupType type = PopupType.info,
      }) {
    final color = _getColor(type);

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    ScaffoldMessenger.of(context).clearSnackBars(); // Clear previous
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getColor(PopupType type) {
    switch (type) {
      case PopupType.error:
        return Colors.red;
      case PopupType.success:
        return Colors.green;
      case PopupType.warning:
        return Colors.orange;
      case PopupType.info:
        return Colors.blue;
    }
  }
}
