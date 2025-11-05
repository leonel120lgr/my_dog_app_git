import 'dart:convert';

class ModelInfoGeneral {
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

  ModelInfoGeneral({
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

  factory ModelInfoGeneral.fromJson(String str) =>
      ModelInfoGeneral.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelInfoGeneral.fromMap(Map<String, dynamic> json) =>
      ModelInfoGeneral(
        weight: Eight.fromMap(json["weight"]),
        height: Eight.fromMap(json["height"]),
        id: json["id"],
        name: json["name"],
        bredFor: json["bred_for"],
        breedGroup: json["breed_group"],
        lifeSpan: json["life_span"],
        temperament: json["temperament"],
        origin: json["origin"],
        referenceImageId: json["reference_image_id"],
        imageDog: ImageDog.fromMap(json["image"]),
        countryCode: json["country_code"],
        description: json["description"],
        history: json["history"],
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

  factory Eight.fromJson(String str) => Eight.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Eight.fromMap(Map<String, dynamic> json) =>
      Eight(imperial: json["imperial"], metric: json["metric"]);

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

  factory ImageDog.fromJson(String str) => ImageDog.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageDog.fromMap(Map<String, dynamic> json) => ImageDog(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
  };
}
