// model_info_dog.dart

import 'dart:convert';

class ModelInfoDog {
  final List<Breed> breeds;
  final String id;
  final String url;
  final int width;
  final int height;

  ModelInfoDog({
    required this.breeds,
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory ModelInfoDog.fromJson(String str) =>
      ModelInfoDog.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory ModelInfoDog.fromMap(Map<String, dynamic> json) => ModelInfoDog(
    // Manejar null o tipos inesperados
    breeds: (json["breeds"] is List)
        ? (json["breeds"] as List)
              .where((x) => x != null)
              .map((x) => Breed.fromMap(x as Map<String, dynamic>))
              .toList()
        : <Breed>[],
    id: (json["id"] ?? "").toString(),
    url: (json["url"] ?? "").toString(),
    width: _toIntSafe(json["width"]),
    height: _toIntSafe(json["height"]),
  );

  Map<String, dynamic> toMap() => {
    "breeds": breeds.map((x) => x.toMap()).toList(),
    "id": id,
    "url": url,
    "width": width,
    "height": height,
  };

  // Convertir a int de forma segura
  static int _toIntSafe(dynamic value) {
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
    }
    return 0; // valor por defecto si falta o es inválido
  }
}

class Breed {
  final String name;
  final String bredFor; // opcional en API, ponemos default ""
  final String breedGroup; // opcional en API, default ""
  final String lifeSpan;
  final String temperament; // opcional, default ""
  final String referenceImageId;

  Breed({
    required this.name,
    required this.bredFor,
    required this.breedGroup,
    required this.lifeSpan,
    required this.temperament,
    required this.referenceImageId,
  });

  factory Breed.fromJson(String str) =>
      Breed.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Breed.fromMap(Map<String, dynamic> json) => Breed(
    name: (json["name"] ?? "").toString(),
    bredFor: (json["bred_for"] ?? "").toString(),
    breedGroup: (json["breed_group"] ?? "").toString(),
    lifeSpan: (json["life_span"] ?? "").toString(),
    temperament: (json["temperament"] ?? "").toString(),
    referenceImageId: (json["reference_image_id"] ?? "").toString(),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "bred_for": bredFor,
    "breed_group": breedGroup,
    "life_span": lifeSpan,
    "temperament": temperament,
    "reference_image_id": referenceImageId,
  };
}

class Eight {
  final String imperial;
  final String metric;

  Eight({required this.imperial, required this.metric});

  factory Eight.fromJson(String str) =>
      Eight.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Eight.fromMap(Map<String, dynamic> json) => Eight(
    imperial: (json["imperial"] ?? "").toString(),
    metric: (json["metric"] ?? "").toString(),
  );

  Map<String, dynamic> toMap() => {"imperial": imperial, "metric": metric};

  // Útil para defaults cuando weight/height vienen null
  factory Eight.empty() => Eight(imperial: "", metric: "");
}
