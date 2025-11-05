import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/const/strings.dart';
import 'package:my_dog_app_flutter/models/model_breeds_dogs.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';
import 'package:my_dog_app_flutter/pages/home/views/details_page_dog.dart';
import 'package:my_dog_app_flutter/pages/home/views/detalis_page_breeds_page.dart';
import 'package:my_dog_app_flutter/providers/dogs_provider.dart';
import 'package:my_dog_app_flutter/widgets/info_reusable.dart';
import 'package:my_dog_app_flutter/widgets/top_snacbar_widget.dart';
import 'package:provider/provider.dart';

class SliverDogsLimit extends StatelessWidget {
  final Size size;
  final List<ModelInfoDog> filteredDogs;

  const SliverDogsLimit({
    super.key,
    required this.size,
    required this.filteredDogs,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4,
      child: Scrollbar(
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                final infoDog = filteredDogs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      //Si la lista de razas esta vacia no lo dejamos avanzar
                      if (infoDog.breeds.isEmpty) {
                        showTopSnackBarReusable(
                          colorInfo: colorsWhite,
                          context: context,
                          message: notInfo,
                          backgroundColor: colorError,
                          icon: FontAwesomeIcons.x,
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => DogsProvider(),
                            child: DetailsPageDog(modelInfoDog: infoDog),
                          ),
                        ),
                      );
                    },
                    child: ChangeNotifierProvider(
                      create: (context) => DogsProvider(),
                      child: InfoReusable(size: size, infoDog: infoDog),
                    ),
                  ),
                );
              },
              itemCount: filteredDogs.length,
            ),
          ],
        ),
      ),
    );
  }
}

class SliverDogBreeds extends StatelessWidget {
  final Size size;
  final List<ModelBreedsDogs> filteredDogs;
  const SliverDogBreeds({
    super.key,
    required this.size,
    required this.filteredDogs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: size.shortestSide / 16),
      child: SizedBox(
        height: size.height / 4,
        child: Scrollbar(
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              SliverList.builder(
                itemBuilder: (context, index) {
                  final infoDog = filteredDogs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 6.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => DogsProvider(),
                              child: DetailsPageBreed(breed: infoDog),
                            ),
                          ),
                        );
                      },
                      child: ChangeNotifierProvider(
                        create: (context) => DogsProvider(),
                        child: InfoReusable(
                          size: size,
                          modelBreedsDogs: infoDog,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: filteredDogs.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
