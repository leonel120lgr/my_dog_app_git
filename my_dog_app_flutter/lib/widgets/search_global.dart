// search_global.dart

import 'package:flutter/material.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:provider/provider.dart';

class SearchGlobal extends StatelessWidget {
  final Function(String)? onchange;
  final TextEditingController searchController;
  final String hintText;
  final FocusNode focusNodeBuscar;

  const SearchGlobal({
    super.key,
    required this.focusNodeBuscar,
    required this.searchController,
    required this.onchange,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Container(
      height: size.height * .062,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: TextField(
        focusNode: focusNodeBuscar,
        controller: searchController,
        cursorColor: kSecondaryColor,

        style: TextStyle(
          fontSize: size.shortestSide / 25,
          fontWeight: FontWeight.bold,
          color: kSecondaryColor,
        ),

        decoration: InputDecoration(
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontSize: size.shortestSide / 25,
            fontWeight: FontWeight.normal,
            color: kSecondaryColor,
          ),
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          hintText: hintText,
        ),
        onChanged: onchange,
      ),
    );
  }
}
