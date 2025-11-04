// drawer_widget.dart
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedToggleSwitch<bool>.dual(
            current: themeNotifier.isDarkMode,
            first: false,
            second: true,
            spacing: 8.0,
            style: ToggleStyle(
              borderColor: kAmbertColor,
              backgroundColor: themeNotifier.isDarkMode
                  ? Colors.white12
                  : Colors.black12,
              indicatorColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [],
            ),
            borderWidth: 2.0,
            height: 36,
            onChanged: (val) {
              themeNotifier.toggleTheme();
            },
            iconBuilder: (val) => val
                ? Icon(color: Colors.black, FontAwesomeIcons.moon)
                : Icon(color: Colors.black, FontAwesomeIcons.sun),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
