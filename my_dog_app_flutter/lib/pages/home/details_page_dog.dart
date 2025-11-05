// details_page_dog.dart

import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';
import 'package:my_dog_app_flutter/providers/dogs_provider.dart';
import 'package:provider/provider.dart';

class DetailsPageDog extends StatelessWidget {
  final ModelInfoDog modelInfoDog;
  final String idDogColletion;

  const DetailsPageDog({
    super.key,
    required this.modelInfoDog,
    required this.idDogColletion,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final favoriteDogDelete = Provider.of<DogsProvider>(context);
    final themeProvider = Provider.of<ThemeNotifier>(context);

    final breed = modelInfoDog.breeds.isNotEmpty
        ? modelInfoDog.breeds[0]
        : null;

    return Scaffold(
      body: Stack(
        children: [
          // Contenedor principal sencillo
          Container(
            height: double.infinity,
            width:
                double.infinity, //Expandimos por todo el tamaño de la pantalla
            color: themeProvider.isDarkMode ? kSecondaryColor : kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: nombre
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.dog),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Name: ${_safeText(breed?.name)}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Card para imagen o placeholder
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: size.shortestSide / 3.5,
                      ),
                      child: CustomCard(
                        color: Colors.grey.shade300,
                        child: SizedBox.expand(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Life span
                    Text(
                      "Life span: ${_safeText(breed?.lifeSpan)}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 16),

                    // Breed group
                    Text(
                      "Breed group:",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    buildBulletListFromCommaSeparated(
                      _safeText(breed?.breedGroup),
                    ),

                    const SizedBox(height: 16),

                    // Bred for
                    Text(
                      "Bred for:",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    buildBulletListFromCommaSeparated(
                      _safeText(breed?.bredFor),
                    ),

                    const SizedBox(height: 16),

                    // Temperament
                    Text(
                      "Temperament:",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    buildBulletListFromCommaSeparated(
                      _safeText(breed?.temperament),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botón favorito flotante
          Positioned(
            right: size.shortestSide / 20,
            top: size.shortestSide / 6,
            child: IconButton(
              onPressed: favoriteDogDelete.isLoadingPostFavorite
                  ? null
                  : () {
                      favoriteDogDelete.postFavoriteDog(
                        idImage: idDogColletion,
                        context: context,
                        nameDog: breed?.name ?? "Unknown",
                      );
                    },
              icon: Icon(
                FontAwesomeIcons.heart,
                color: colorError,
                size: size.shortestSide / 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Convierte una cadena separada por comas en una lista con viñetas "°"
  // Si la cadena está vacía, muestra un texto "No disponible".
  static Widget buildBulletListFromCommaSeparated(String value) {
    final items = value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 4),
        child: Text("No disponible", style: TextStyle(color: Colors.black54)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text("° $item"),
            ),
          )
          .toList(),
    );
  }

  // Devuelve texto seguro evitando "null" visibles
  static String _safeText(String? value) {
    final v = value?.trim() ?? "";
    return v.isEmpty ? "No disponible" : v;
  }
}
