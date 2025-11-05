// dogs_provider.dart

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/const/strings.dart';
import 'package:my_dog_app_flutter/const/url_base_api_key.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';
import 'package:my_dog_app_flutter/widgets/top_snacbar_widget.dart';

class DogsProvider extends ChangeNotifier {
  DogsProvider({int limitDog = 20}) {
    getInfoDog(limitDog: limitDog);
  }

  bool _disposed = false;
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

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

  bool isLoadingGetInfoDogModel = false;

  ModelInfoDog? modelInfoDog;
  Future<void> getInfoDogBy({required String idImage}) async {
    try {
      isLoadingGetInfoDogModel = true;
      safeNotify();

      final response = await http.get(Uri.parse("$baseURL/v1/images/$idImage"));

      if (_disposed) return;

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        modelInfoDog = ModelInfoDog.fromMap(jsonResponse);
        safeNotify();
      } else {
        log(response.body);
        modelInfoDog = null;
        safeNotify();
      }
    } catch (e) {
      modelInfoDog = null;
    } finally {
      if (_disposed) return;
      isLoadingGetInfoDogModel = false;
      safeNotify();
    }
  }

  bool isLoadingPostInfoDog = false;

  Future<void> postInfoDogBy({
    required File file,
    required BuildContext context,
  }) async {
    try {
      isLoadingPostInfoDog = true;
      safeNotify();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseURL/images/upload'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.headers.addAll(headersGlobal);

      http.StreamedResponse response = await request.send();
      final responseBODY = await response.stream.bytesToString();

      if (_disposed) return;

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(responseBODY);

        // Evitar usar context si la vista fue desmontada
        if (context.mounted) {
          showTopSnackBarReusable(
            colorInfo: colorsWhite,
            icon: FontAwesomeIcons.circleCheck,
            context: context,
            message: "Se subió foto correctamente",
            backgroundColor: colorSucces,
          );
        }
        safeNotify();
      } else {
        modelInfoDog = null;
        safeNotify();
      }
    } catch (e) {
      modelInfoDog = null;
    } finally {
      if (_disposed) return;
      isLoadingPostInfoDog = false;
      safeNotify();
    }
  }

  bool isLoadingPostFavorite = false;
  Future<void> postFavoriteDog({
    required String idImage,
    required BuildContext context,
    required String nameDog,
  }) async {
    try {
      isLoadingPostFavorite = true;
      safeNotify();

      final response = await http.post(
        Uri.parse("$baseURL/v1/favourites"),
        headers: headersGlobal,
        body: {"image_id": idImage, "user_id": "UsuarioInventado"},
      );

      if (_disposed) return;

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        if (context.mounted) {
          showTopSnackBarReusable(
            context: context,
            message: "$nameDog $addFavorite",
            backgroundColor: colorSucces,
            icon: FontAwesomeIcons.check,
            colorInfo: colorsWhite,
          );
        }
        safeNotify();
      } else {
        log(response.body);
        log(response.statusCode.toString());
        safeNotify();
      }
    } catch (e) {
      // log(e.toString());
    } finally {
      if (_disposed) return;
      isLoadingPostFavorite = false;
      safeNotify();
    }
  }
}
