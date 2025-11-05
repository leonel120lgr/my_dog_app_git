import 'package:my_dog_app_flutter/models/model_breeds_dogs.dart';

/// Returns a trimmed string, or a fallback if it's null/empty.
String safe(String? value, {String fallback = "No disponible"}) {
  final s = (value ?? "").trim();
  return s.isEmpty ? fallback : s;
}

/// Sanitizes a metric/imperial range, preferring metric if valid.

/// Builds the breed info values list using provided breed fields.
/// Pass English labels via overrides if you want English output.
List<String> buildBreedValues({
  required ModelBreedsDogs breed,
  // Localization overrides
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
