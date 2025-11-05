// dogs_provider.dart

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_dog_app_flutter/const/url_base_api_key.dart';
import 'package:my_dog_app_flutter/models/model_breeds_dogs.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';

class DogsProvider extends ChangeNotifier {
  //El limit por default siempre es 20, pero cuando el usuario lo mande a llamar puede actulizarlo
  DogsProvider({int limitDog = 20}) {
    // Constructor para llamar automáticamente los métodos
    getInfoDog(limitDog: limitDog);
    getBreedDogs();
  }

  bool _disposed = false;
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
  //Evita que se haga un dispose inecesario que genere conflicto entre el get de los datos

  void safeNotify() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  bool isLoadingGetInfoDog = false;

  List<ModelInfoDog> infoDogList = [];
  Future<void> getInfoDog({required int limitDog}) async {
    try {
      isLoadingGetInfoDog = true;
      safeNotify();

      final response = await http.get(
        Uri.parse("$baseURL/v1/images/search?limit=$limitDog"),
        headers: headersGlobal,
      );

      if (_disposed) return; // si ya se desmontó, corta aquí

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        infoDogList = jsonResponse
            .map<ModelInfoDog>((dynamic item) => ModelInfoDog.fromMap(item))
            .toList();
        safeNotify();
      } else {
        log(response.body);
        infoDogList = [];
        safeNotify();
      }
    } catch (e) {
      infoDogList = [];
      log(e.toString());
    } finally {
      if (_disposed) return;
      isLoadingGetInfoDog = false;
      safeNotify();
    }
  }

  bool isLoadingGetBreedsDogs = false;

  List<ModelBreedsDogs> breedsDogList = [];
  Future<void> getBreedDogs() async {
    try {
      isLoadingGetBreedsDogs = true;
      safeNotify();

      final response = await http.get(
        Uri.parse("$baseURL/v1/breeds"),
        headers: headersGlobal,
      );

      if (_disposed) return; // si ya se desmontó, corta aquí

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        breedsDogList = jsonResponse
            .map<ModelBreedsDogs>(
              (dynamic item) => ModelBreedsDogs.fromMap(item),
            )
            .toList();
        safeNotify();
      } else {
        log(response.body);
        breedsDogList = [];
        safeNotify();
      }
    } catch (e) {
      breedsDogList = [];
      log(e.toString());
    } finally {
      if (_disposed) return;
      isLoadingGetBreedsDogs = false;
      safeNotify();
    }
  }
}
