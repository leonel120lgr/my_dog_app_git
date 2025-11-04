import 'package:flutter/material.dart';
import 'package:my_dog_app_flutter/widgets/splash_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    //Pantalla de carga principal
    Size size = MediaQuery.of(context).size;

    return SplashWidget(size: size);
  }
}
