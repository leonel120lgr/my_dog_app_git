// home_screen.dart (only the changed portion below shows the new method and call)

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/const/strings.dart';
import 'package:my_dog_app_flutter/models/model_breeds_dogs.dart';
import 'package:my_dog_app_flutter/providers/dogs_provider.dart';
import 'package:my_dog_app_flutter/widgets/drawer_widget.dart';
import 'package:my_dog_app_flutter/widgets/dropbutton.dart';
import 'package:my_dog_app_flutter/widgets/search_global.dart';
import 'package:my_dog_app_flutter/widgets/sliver_dogs_widgets.dart';
import 'package:my_dog_app_flutter/widgets/top_snacbar_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNodeBuscar = FocusNode();

  String searchText = '';
  int? currentLimit;

  final List<int> limitOptions = [5, 10, 20, 50, 100];

  @override
  void dispose() {
    searchController.dispose();
    focusNodeBuscar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final providerDog = Provider.of<DogsProvider>(context);

    final List<ModelBreedsDogs> filteredDogsBreeds = providerDog.breedsDogList
        .where(
          (dog) => dog.name.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(title: const Text("Home perritos")),
      body: SingleChildScrollView(
        // TODO Cerrando el teclado si se hace el scroll vertical para el usuario pueda ver contenido deseado
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.only(
            top: size.shortestSide / 16,
            left: 12,
            right: 12,
          ),
          child: Column(
            children: [
              // Lista de perros razas
              if (providerDog.isLoadingGetBreedsDogs) ...[
                Center(
                  child: CircularProgressIndicator(
                    color: themeNotifier.isDarkMode
                        ? kPrimaryColor
                        : kSecondaryColor,
                  ),
                ),
              ] else if (providerDog.breedsDogList.isNotEmpty) ...[
                SearchGlobal(
                  focusNodeBuscar: focusNodeBuscar,
                  searchController: searchController,
                  onchange: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  hintText: searchDog,
                ),
                SliverDogBreeds(filteredDogs: filteredDogsBreeds, size: size),
              ] else ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No hay perritos disponibles.'),
                ),
              ],
              if (providerDog.isLoadingGetInfoDog) ...[
                Center(
                  child: CircularProgressIndicator(
                    color: themeNotifier.isDarkMode
                        ? kPrimaryColor
                        : kSecondaryColor,
                  ),
                ),
              ] else if (providerDog.infoDogList.isNotEmpty) ...[
                // Reemplaza tu SizedBox anterior con esta llamada:
                LimitSelectorCard(
                  size: size,

                  currentLimit: currentLimit,
                  limitOptions: limitOptions,
                  onChanged: (value) {
                    if (currentLimit == value)
                      return; // evitar llamadas repetidas

                    // Validación
                    if (value <= 0) {
                      showTopSnackBarReusable(
                        colorInfo: colorsWhite,
                        context: context,
                        message: 'El límite debe ser mayor que 0',
                        backgroundColor: colorError,
                        icon: FontAwesomeIcons.triangleExclamation,
                      );
                      return;
                    }

                    setState(() {
                      currentLimit = value;
                    });

                    // Llama al provider
                    providerDog.getInfoDog(limitDog: value);
                  },
                ),

                const SizedBox(height: 12),
                SliverDogsLimit(
                  size: size,
                  filteredDogs: providerDog.infoDogList,
                ),
              ] else ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No hay perritos disponibles.'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
