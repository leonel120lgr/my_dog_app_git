// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/models/model_breeds_dogs.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';
import 'package:my_dog_app_flutter/widgets/cached_image_widget.dart';
import 'package:provider/provider.dart';

class InfoReusable extends StatelessWidget {
  final Size size;
  final ModelInfoDog? infoDog;
  final ModelBreedsDogs? modelBreedsDogs;
  const InfoReusable({
    super.key,
    required this.size,
    this.infoDog,
    this.modelBreedsDogs,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return SizedBox(
      // Define tamaño del card para que sus hijos puedan expandirse
      width: size.width * 0.7,
      height: size.height / 4 - 12, // un poco menos para considerar padding
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          // Asegura que la imagen respete el borderRadius del card
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Hace que la imagen ocupe todo el espacio del card
              Positioned.fill(
                child: cachedImageNetwork(
                  infoDog != null
                      ? infoDog!.url
                      : modelBreedsDogs!.imageDog.url,
                ),
              ),
              // Overlay inferior con el id
              PositionedBottom(
                themeNotifier: themeNotifier,
                infoDog: infoDog,
                modelBreedsDogs: modelBreedsDogs,
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Metodo reusable bottom
class PositionedBottom extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  final ModelInfoDog? infoDog;
  final ModelBreedsDogs? modelBreedsDogs;
  final Size size;
  final bool visibleIcon;
  const PositionedBottom({
    super.key,
    required this.themeNotifier,
    this.infoDog,
    this.modelBreedsDogs,
    required this.size,
    this.visibleIcon =
        true, // en dado caso que no quiero se vea lo mando como false
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: themeNotifier.isDarkMode ? kPrimaryColor : kSecondaryColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                maxLines: 1,
                !visibleIcon && infoDog != null
                    ?
                      //Como estamos en los detalles de pagina mostramos este no
                      "Name: ${infoDog!.breeds.first.name}"
                    : infoDog != null
                    ? "ID: ${infoDog?.id}" //Abra ocaciones en las que el nombre no este disponible entonces motramos el id en el home
                    : "Breed: ${modelBreedsDogs?.name}",
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
            ),
            Visibility(
              visible: visibleIcon,
              child: Padding(
                padding: EdgeInsetsGeometry.only(right: size.shortestSide / 64),
                child: Icon(
                  FontAwesomeIcons.circleArrowRight,
                  color: themeNotifier.isDarkMode ? Colors.black : colorsWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
