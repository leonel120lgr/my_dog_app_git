// cached_image_widget.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';

Widget cachedImageNetwork(String imageURL) {
  return CachedNetworkImage(
    imageUrl: imageURL,
    fit: BoxFit.cover, // Esto hará que la imagen cubra el contenedor
    placeholder: (context, url) => const Center(
      child: CircularProgressIndicator(color: kPrimaryColor, strokeWidth: 2),
    ),
    errorWidget: (context, url, error) => Container(color: Colors.white),
  );
}
