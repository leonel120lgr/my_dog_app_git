import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_dog_app_flutter/colors/theme_app.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:my_dog_app_flutter/const/strings.dart';
import 'package:my_dog_app_flutter/pages/home/home_screen.dart';
import 'package:my_dog_app_flutter/pages/no_internet_screen.dart';
import 'package:my_dog_app_flutter/providers/dogs_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Evita que usuario ponga el dispositvo en horizontal
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(mianAPP());
}

Widget mianAPP() => ChangeNotifierProvider(
  create: (context) => ThemeNotifier(), // Provider para cambiar de tema
  child: MainApp(),
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  void _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });

    // Escuchar cambios en la conectividad
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Provider para cambiar de tema
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      //Tema de la aplicación
      theme: ThemeAplication(MediaQuery.of(context).size, context).lightTheme,
      darkTheme: ThemeAplication(
        MediaQuery.of(context).size,
        context,
      ).darkTheme,
      themeMode: themeNotifier.useSystemTheme
          ? ThemeMode.system
          : (themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light),

      debugShowCheckedModeBanner: false,
      title: titleApp,
      home: _isConnected
          ? ChangeNotifierProvider(
              create: (context) => DogsProvider(),
              child: HomeScreen(),
            )
          : NoInternetScreen(),
    );
  }
}
