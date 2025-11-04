import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showTopSnackBarReusable({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required IconData icon,
  TextStyle textStyle = const TextStyle(color: Colors.black),
}) {
  // Asegura que existe un Overlay en el árbol
  final overlayState = Overlay.of(context);
  showTopSnackBar(
    displayDuration: Duration(seconds: 2),
    overlayState,
    CustomSnackBar.success(
      backgroundColor: backgroundColor,
      icon: Icon(icon, color: Colors.white, size: 20),
      textStyle: textStyle,
      message: message,
    ),
  );
}
