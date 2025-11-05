// model_breeds_dogs.dart
import 'dart:convert';

class ModelBreedsDogs {
  final Eight weight;
  final Eight height;
  final int id;
  final String name;
  final String bredFor;
  final String breedGroup;
  final String lifeSpan;
  final String temperament;
  final String origin;
  final String referenceImageId;
  final ImageDog imageDog;
  final String countryCode;
  final String description;
  final String history;

  ModelBreedsDogs({
    required this.weight,
    required this.height,
    required this.id,
    required this.name,
    required this.bredFor,
    required this.breedGroup,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.referenceImageId,
    required this.imageDog,
    required this.countryCode,
    required this.description,
    required this.history,
  });

  factory ModelBreedsDogs.fromJson(String str) =>
      ModelBreedsDogs.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory ModelBreedsDogs.fromMap(Map<String, dynamic> json) => ModelBreedsDogs(
    // Si weight/height son null o no son Map, usamos defaults vacíos
    weight: Eight.fromMap(
      (json["weight"] is Map<String, dynamic>)
          ? json["weight"] as Map<String, dynamic>
          : <String, dynamic>{},
    ),
    height: Eight.fromMap(
      (json["height"] is Map<String, dynamic>)
          ? json["height"] as Map<String, dynamic>
          : <String, dynamic>{},
    ),
    // Si id es null o no numérico, default 0
    id: (json["id"] is int)
        ? json["id"] as int
        : (json["id"] is num)
        ? (json["id"] as num).toInt()
        : 0,
    // Strings con default a cadena vacía
    name: json["name"]?.toString() ?? "",
    bredFor: json["bred_for"]?.toString() ?? "",
    breedGroup: json["breed_group"]?.toString() ?? "",
    lifeSpan: json["life_span"]?.toString() ?? "",
    temperament: json["temperament"]?.toString() ?? "",
    origin: json["origin"]?.toString() ?? "",
    referenceImageId: json["reference_image_id"]?.toString() ?? "",
    imageDog: ImageDog.fromMap(
      (json["image"] is Map<String, dynamic>)
          ? json["image"] as Map<String, dynamic>
          : <String, dynamic>{},
    ),
    countryCode: json["country_code"]?.toString() ?? "",
    description: json["description"]?.toString() ?? "",
    history: json["history"]?.toString() ?? "",
  );

  Map<String, dynamic> toMap() => {
    "weight": weight.toMap(),
    "height": height.toMap(),
    "id": id,
    "name": name,
    "bred_for": bredFor,
    "breed_group": breedGroup,
    "life_span": lifeSpan,
    "temperament": temperament,
    "origin": origin,
    "reference_image_id": referenceImageId,
    "image": imageDog.toMap(),
    "country_code": countryCode,
    "description": description,
    "history": history,
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
    imperial: json["imperial"]?.toString() ?? "",
    metric: json["metric"]?.toString() ?? "",
  );

  Map<String, dynamic> toMap() => {"imperial": imperial, "metric": metric};
}

class ImageDog {
  final String id;
  final int width;
  final int height;
  final String url;

  ImageDog({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  });

  factory ImageDog.fromJson(String str) =>
      ImageDog.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory ImageDog.fromMap(Map<String, dynamic> json) => ImageDog(
    id: json["id"]?.toString() ?? "",
    width: (json["width"] is int)
        ? json["width"] as int
        : (json["width"] is num)
        ? (json["width"] as num).toInt()
        : 0,
    height: (json["height"] is int)
        ? json["height"] as int
        : (json["height"] is num)
        ? (json["height"] as num).toInt()
        : 0,
    url: json["url"]?.toString() ?? "",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
  };
}
