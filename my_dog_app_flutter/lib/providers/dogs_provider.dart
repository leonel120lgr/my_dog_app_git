import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/const/url_base_api_key.dart';
import 'package:my_dog_app_flutter/models/model_info_dog.dart';
import 'package:my_dog_app_flutter/pages/home/home_screen.dart';
import 'package:my_dog_app_flutter/widgets/top_snacbar_widget.dart';

class DogsProvider extends ChangeNotifier {
  DogsProvider({
    int limitDog = 20,
    bool navigate = false,
    required BuildContext context,
  }) {
    getInfoDog(limitDog: limitDog, navigate: navigate, context: context);
  }

  bool isLoadingGetInfoDog = false;

  List<ModelInfoDog> infoDogList = [];
  Future<void> getInfoDog({
    required int limitDog,
    required bool navigate,
    required BuildContext context,
  }) async {
    try {
      isLoadingGetInfoDog = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse("$baseURL/v1/images/search?limit=$limitDog"),
        headers: headersGlobal,
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(response.body);

        final List<dynamic> jsonResponse = jsonDecode(response.body);

        infoDogList = jsonResponse
            .map<ModelInfoDog>((dynamic item) => ModelInfoDog.fromMap(item))
            .toList();

        notifyListeners();

        if (navigate) {
          //Si venimos del splash screen navegamos al home page

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        log(response.body);

        infoDogList = [];
      }
    } catch (e) {
      // TODO

      infoDogList = [];
      log(e.toString());
    } finally {
      isLoadingGetInfoDog = false;
      notifyListeners();
    }
  }

  bool isLoadingGetInfoDogModel = false;

  ModelInfoDog? modelInfoDog;
  Future<void> getInfoDogBy({required String idImage}) async {
    try {
      isLoadingGetInfoDogModel = true;
      notifyListeners();
      final response = await http.get(Uri.parse("$baseURL/v1/images/$idImage"));

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(response.body);
        final Map<String, dynamic> jsonResponse =
            jsonDecode(response.body) as Map<String, dynamic>;

        modelInfoDog = ModelInfoDog.fromMap(jsonResponse);

        notifyListeners();
      } else {
        log(response.body);
        modelInfoDog = null;
      }
    } catch (e) {
      // TODO

      modelInfoDog = null;
    } finally {
      isLoadingGetInfoDogModel = false;
      notifyListeners();
    }
  }

  bool isLoadingPostInfoDog = false;

  Future<void> postInfoDogBy({
    required File file,
    required BuildContext context,
  }) async {
    try {
      isLoadingPostInfoDog = true;
      notifyListeners();
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseURL/images/upload'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.headers.addAll(headersGlobal);

      http.StreamedResponse response = await request.send();
      final responseBODY = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(responseBODY);

        showTopSnackBarReusable(
          icon: FontAwesomeIcons.circleCheck,
          // ignore: use_build_context_synchronously
          context: context,
          message: "Se subió foto correctamente",
          backgroundColor: colorSucces,
        );
        notifyListeners();
      } else {
        modelInfoDog = null;
      }
    } catch (e) {
      // TODO

      modelInfoDog = null;
    } finally {
      isLoadingPostInfoDog = false;
      notifyListeners();
    }
  }
}
