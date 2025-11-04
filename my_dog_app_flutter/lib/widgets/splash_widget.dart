import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/const/strings.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(assetWelcome, width: size.width * 0.65),
                SpinKitPumpingHeart(color: Colors.red, size: size.shortestSide),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
