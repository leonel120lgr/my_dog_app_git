import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/const/const_lists.dart';
import 'package:my_dog_app_flutter/const/strings.dart';
import 'package:my_dog_app_flutter/models/model_breeds_dogs.dart';
import 'package:my_dog_app_flutter/utils/breed_text_helpers.dart';
import 'package:my_dog_app_flutter/widgets/cached_image_widget.dart';
import 'package:my_dog_app_flutter/widgets/drawer_widget.dart';
import 'package:my_dog_app_flutter/widgets/info_reusable.dart';
import 'package:provider/provider.dart';

class DetailsPageBreed extends StatelessWidget {
  final ModelBreedsDogs breed;

  const DetailsPageBreed({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(breed.name.isNotEmpty ? breed.name : "Detalle de raza"),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.shortestSide / 32),
        child: SafeArea(
          child: SingleChildScrollView(
            child: CustomCard(
              elevation: 3,
              color: themeNotifier.isDarkMode ? kSecondaryColor : kPrimaryColor,
              borderRadius: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen principal con overlay reutilizable
                  Stack(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: size.shortestSide / 2,
                        ),
                        child: SizedBox(
                          width: size.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            child: cachedImageNetwork(breed.imageDog.url),
                          ),
                        ),
                      ),

                      PositionedBottom(
                        themeNotifier: themeNotifier,

                        modelBreedsDogs: breed,
                        size: size,
                        visibleIcon: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Lista de información
                  Column(
                    children: List.generate(breedInfoPageMainList.length, (
                      index,
                    ) {
                      final label = breedInfoPageMainList[index];
                      final value = buildBreedValues(breed: breed)[index];

                      return ListTile(
                        contentPadding: EdgeInsets.all(size.shortestSide / 128),
                        leading: CustomCard(
                          elevation: 3,
                          color: themeNotifier.isDarkMode
                              ? kPrimaryColor
                              : kSecondaryColor,
                          borderRadius: 3,
                          child: Icon(
                            iconListbreedPagemainInfo[index],
                            color: themeNotifier.isDarkMode
                                ? Colors.black
                                : colorsWhite,
                          ),
                        ),
                        title: Text(
                          "$label : $value",
                          style: TextStyle(
                            fontFamily: tipeOpenSans,
                            fontWeight: FontWeight.w600,
                            color: themeNotifier.isDarkMode
                                ? colorsWhite
                                : Colors.black,
                          ),
                        ),
                      );
                    }),
                  ),

                  // Campos opcionales de descripción/historia si existen
                  if (breed.description.isNotEmpty ||
                      breed.history.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.shortestSide / 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (breed.description.isNotEmpty) ...[
                            Text(
                              breed.description,
                              style: TextStyle(
                                fontFamily: tipeOpenSans,
                                color: themeNotifier.isDarkMode
                                    ? colorsWhite
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          if (breed.history.isNotEmpty)
                            Text(
                              breed.history,
                              style: TextStyle(
                                fontFamily: tipeOpenSans,
                                color: themeNotifier.isDarkMode
                                    ? colorsWhite
                                    : Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Pequeño adaptador para usar PositionedBottom sin cambiar tu widget existente
class InfoReusableModel {
  final String title;
  final String subtitle;
  final bool rightIconVisible;
  InfoReusableModel({
    required this.title,
    required this.subtitle,
    required this.rightIconVisible,
  });
}
