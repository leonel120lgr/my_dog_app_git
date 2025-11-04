// home_screen.dart
import 'package:flutter/material.dart';
import 'package:my_dog_app_flutter/providers/dogs_provider.dart';
import 'package:my_dog_app_flutter/widgets/cached_image_widget.dart';
import 'package:my_dog_app_flutter/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final listInfoDog = Provider.of<DogsProvider>(context);

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(title: const Text("Home perritos")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 4,
              child: Scrollbar(
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  slivers: [
                    SliverList.builder(
                      itemCount: listInfoDog.infoDogList.length,
                      itemBuilder: (context, index) {
                        final infoDog = listInfoDog.infoDogList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 6.0,
                          ),
                          child: SizedBox(
                            // Define tamaño del card para que sus hijos puedan expandirse
                            width: size.width * 0.7,
                            height:
                                size.height / 4 -
                                12, // un poco menos para considerar padding
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: ClipRRect(
                                // Asegura que la imagen respete el borderRadius del card
                                borderRadius: BorderRadius.circular(30),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Hace que la imagen ocupe todo el espacio del card
                                    Positioned.fill(
                                      child: cachedImageNetwork(infoDog.url),
                                    ),
                                    // Overlay inferior con el id
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                        ),
                                        child: Text(
                                          infoDog.id,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
