import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showTopSnackBarReusable({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required IconData icon,
  required Color colorInfo,
}) {
  // Asegura que existe un Overlay en el árbol
  final overlayState = Overlay.of(context);
  showTopSnackBar(
    displayDuration: Duration(seconds: 2),
    overlayState,
    CustomSnackBar.error(
      maxLines: 10,
      backgroundColor: backgroundColor,
      icon: Icon(icon, color: colorInfo, size: 20),
      textStyle: TextStyle(color: colorInfo),
      message: message,
    ),
  );
}
