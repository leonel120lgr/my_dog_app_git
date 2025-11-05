// home_screen.dart (only the changed portion below shows the new method and call)

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/const/strings.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';
import 'package:my_dog_app_flutter/pages/home/details_page_dog.dart';
import 'package:my_dog_app_flutter/providers/dogs_provider.dart';
import 'package:my_dog_app_flutter/widgets/drawer_widget.dart';
import 'package:my_dog_app_flutter/widgets/dropbutton.dart';
import 'package:my_dog_app_flutter/widgets/info_reusable.dart';
import 'package:my_dog_app_flutter/widgets/search_global.dart';
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
    final listInfoDog = Provider.of<DogsProvider>(context);

    final List<ModelInfoDog> filteredDogs = listInfoDog.infoDogList
        .where((dog) => dog.id.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(title: const Text("Home perritos")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: size.shortestSide / 16,
            left: 12,
            right: 12,
          ),
          child: Column(
            children: [
              if (listInfoDog.isLoadingGetInfoDog) ...[
                Center(
                  child: CircularProgressIndicator(
                    color: themeNotifier.isDarkMode
                        ? kPrimaryColor
                        : kSecondaryColor,
                  ),
                ),
              ] else if (listInfoDog.infoDogList.isNotEmpty) ...[
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
                    listInfoDog.getInfoDog(limitDog: value);
                  },
                ),

                const SizedBox(height: 12),
                SliverReusable(size: size, filteredDogs: filteredDogs),
              ] else ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No hay perritos disponibles.'),
                ),
              ],

              // Lista de perros razas
            ],
          ),
        ),
      ),
    );
  }
}

class SliverReusable extends StatelessWidget {
  final Size size;
  final List<ModelInfoDog> filteredDogs;
  const SliverReusable({
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
                            child: DetailsPageDog(
                              modelInfoDog: infoDog,
                              idDogColletion: infoDog.id,
                            ),
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
