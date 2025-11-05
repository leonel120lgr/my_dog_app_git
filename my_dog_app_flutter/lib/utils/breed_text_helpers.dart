import 'package:my_dog_app_flutter/models/model_breeds_dogs.dart';

//Evita que existan datos nullos o vacios
String safe(String? value, {String fallback = "No disponible"}) {
  final s = (value ?? "").trim();
  return s.isEmpty ? fallback : s;
}

//Crea una lista para que modelbreds se comporte de una manera más limpia y ordenada
List<String> buildBreedValues({
  required ModelBreedsDogs breed,

  String unavailableText = "No disponible",
}) {
  return [
    safe(breed.name, fallback: unavailableText),
    safe(breed.bredFor, fallback: unavailableText),
    safe(breed.breedGroup, fallback: unavailableText),
    safe(breed.lifeSpan, fallback: unavailableText),
    safe(breed.temperament, fallback: unavailableText),
    safe(breed.origin, fallback: unavailableText),
  ];
}
