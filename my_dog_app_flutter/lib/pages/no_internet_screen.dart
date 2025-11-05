import 'package:flutter/material.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/main.dart';
import 'package:provider/provider.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 100, color: Colors.red),
            SizedBox(height: 20),
            Text(
              "No tienes conexión a internet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Verifica tu conexión e inténtalo de nuevo.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Reiniciar la aplicación para volver a verificar la conexión
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => ThemeNotifier(),
                      child: MainApp(),
                    ),
                  ),
                );
              },
              child: Text(
                "Reintentar",
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? colorsWhite : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
