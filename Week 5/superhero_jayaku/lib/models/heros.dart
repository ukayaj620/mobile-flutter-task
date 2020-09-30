import 'dart:convert';

HeroModel heroDataFromJson(String str) => HeroModel.fromJson(json.decode(str));

String heroDataToJson(HeroModel data) => json.encode(data.toJson());

class HeroModel {
  HeroModel({
    this.response,
    this.resultsFor,
    this.results,
  });

  String response;
  String resultsFor;
  List<Result> results;

  factory HeroModel.fromJson(Map<String, dynamic> json) => HeroModel(
    response: json["response"],
    resultsFor: json["results-for"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "results-for": resultsFor,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.powerstats,
    this.biography,
    this.appearance,
    this.work,
    this.connections,
    this.image,
  });

  String id;
  String name;
  Powerstats powerstats;
  Biography biography;
  Appearance appearance;
  Work work;
  Connections connections;
  HeroImage image;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    powerstats: Powerstats.fromJson(json["powerstats"]),
    biography: Biography.fromJson(json["biography"]),
    appearance: Appearance.fromJson(json["appearance"]),
    work: Work.fromJson(json["work"]),
    connections: Connections.fromJson(json["connections"]),
    image: HeroImage.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "powerstats": powerstats.toJson(),
    "biography": biography.toJson(),
    "appearance": appearance.toJson(),
    "work": work.toJson(),
    "connections": connections.toJson(),
    "image": image.toJson(),
  };
}

class Appearance {
  Appearance({
    this.gender,
    this.race,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
  });

  String gender;
  String race;
  List<String> height;
  List<String> weight;
  String eyeColor;
  String hairColor;

  factory Appearance.fromJson(Map<String, dynamic> json) => Appearance(
    gender: json["gender"],
    race: json["race"],
    height: List<String>.from(json["height"].map((x) => x)),
    weight: List<String>.from(json["weight"].map((x) => x)),
    eyeColor: json["eye-color"],
    hairColor: json["hair-color"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "race": race,
    "height": List<dynamic>.from(height.map((x) => x)),
    "weight": List<dynamic>.from(weight.map((x) => x)),
    "eye-color": eyeColor,
    "hair-color": hairColor,
  };
}

class Biography {
  Biography({
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  });

  String fullName;
  String alterEgos;
  List<String> aliases;
  String placeOfBirth;
  String firstAppearance;
  String publisher;
  String alignment;

  factory Biography.fromJson(Map<String, dynamic> json) => Biography(
    fullName: json["full-name"],
    alterEgos: json["alter-egos"],
    aliases: List<String>.from(json["aliases"].map((x) => x)),
    placeOfBirth: json["place-of-birth"],
    firstAppearance: json["first-appearance"],
    publisher: json["publisher"],
    alignment: json["alignment"],
  );

  Map<String, dynamic> toJson() => {
    "full-name": fullName,
    "alter-egos": alterEgos,
    "aliases": List<dynamic>.from(aliases.map((x) => x)),
    "place-of-birth": placeOfBirth,
    "first-appearance": firstAppearance,
    "publisher": publisher,
    "alignment": alignment,
  };
}

class Connections {
  Connections({
    this.groupAffiliation,
    this.relatives,
  });

  String groupAffiliation;
  String relatives;

  factory Connections.fromJson(Map<String, dynamic> json) => Connections(
    groupAffiliation: json["group-affiliation"],
    relatives: json["relatives"],
  );

  Map<String, dynamic> toJson() => {
    "group-affiliation": groupAffiliation,
    "relatives": relatives,
  };
}

class HeroImage {
  HeroImage({
    this.url,
  });

  String url;

  factory HeroImage.fromJson(Map<String, dynamic> json) => HeroImage(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

class Powerstats {
  Powerstats({
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  });

  String intelligence;
  String strength;
  String speed;
  String durability;
  String power;
  String combat;

  factory Powerstats.fromJson(Map<String, dynamic> json) => Powerstats(
    intelligence: json["intelligence"],
    strength: json["strength"],
    speed: json["speed"],
    durability: json["durability"],
    power: json["power"],
    combat: json["combat"],
  );

  Map<String, dynamic> toJson() => {
    "intelligence": intelligence,
    "strength": strength,
    "speed": speed,
    "durability": durability,
    "power": power,
    "combat": combat,
  };
}

class Work {
  Work({
    this.occupation,
    this.base,
  });

  String occupation;
  String base;

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    occupation: json["occupation"],
    base: json["base"],
  );

  Map<String, dynamic> toJson() => {
    "occupation": occupation,
    "base": base,
  };
}
