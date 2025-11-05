import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/const/const_lists.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';
import 'package:my_dog_app_flutter/widgets/cached_image_widget.dart';
import 'package:my_dog_app_flutter/widgets/drawer_widget.dart';
import 'package:my_dog_app_flutter/widgets/info_reusable.dart';
import 'package:provider/provider.dart';

class DetailsPageDog extends StatelessWidget {
  final ModelInfoDog modelInfoDog;

  const DetailsPageDog({super.key, required this.modelInfoDog});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(title: Text(modelInfoDog.id)),
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
                  // Card para imagen
                  Stack(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: size.shortestSide / 2,
                        ),
                        child: SizedBox(
                          width: size.width,

                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: cachedImageNetwork(modelInfoDog.url),
                          ),
                        ),
                      ),

                      PositionedBottom(
                        themeNotifier: themeNotifier,
                        infoDog: modelInfoDog,
                        size: size,
                        visibleIcon: false, //ocultar boton right
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Column(
                    children: List.generate(breedInfoList.length, (index) {
                      // Se extrae el primer breed si existe
                      final Breed? breed = modelInfoDog.breeds.isNotEmpty
                          ? modelInfoDog.breeds.first
                          : null;

                      // Función para texto seguro en caso de no exista el dato
                      String safe(String? valueSafe) {
                        final safeData = valueSafe?.trim() ?? "";
                        return safeData.isEmpty ? "No disponible" : safeData;
                      }

                      // Mapeo por índice -- campo del breed
                      String value;
                      switch (index) {
                        case 0:
                          value = safe(breed?.name);
                          break;
                        case 1:
                          value = safe(breed?.bredFor);
                          break;
                        case 2:
                          value = safe(breed?.breedGroup);
                          break;
                        case 3:
                          value = safe(breed?.lifeSpan);
                          break;
                        case 4:
                          value = safe(breed?.temperament);
                          break;
                        case 5:
                          value = safe(breed?.referenceImageId);
                          break;
                        default:
                          value = "No disponible";
                      }

                      return ListTile(
                        contentPadding: EdgeInsets.all(size.shortestSide / 32),
                        leading: CustomCard(
                          elevation: 3,
                          color: themeNotifier.isDarkMode
                              ? kPrimaryColor
                              : kSecondaryColor,
                          borderRadius: 3,
                          child: Icon(
                            iconListbreedInfo[index],
                            color: themeNotifier.isDarkMode
                                ? Colors.black
                                : colorsWhite,
                          ),
                        ),
                        title: Text(
                          "${breedInfoList[index]} : $value",
                          style: TextStyle(
                            color: themeNotifier.isDarkMode
                                ? colorsWhite
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
