class PokemonDetailModel {
  PokemonDetailModel({
    this.baseHappiness,
    this.captureRate,
    this.flavorTextEntries,
    this.genera,
    this.hasGenderDifferences,
    this.hatchCounter,
    this.id,
    this.name,
    this.order,
  });

  PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    baseHappiness = json['base_happiness'];
    captureRate = json['capture_rate'];
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = <FlavorTextEntries>[];
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries!.add(FlavorTextEntries.fromJson(v));
      });
    }

    if (json['genera'] != null) {
      genera = <Genera>[];
      json['genera'].forEach((v) {
        genera!.add(Genera.fromJson(v));
      });
    }
    hasGenderDifferences = json['has_gender_differences'];
    hatchCounter = json['hatch_counter'];
    id = json['id'];
    isLegendary = json['is_legendary'];
    name = json['name'];
    order = json['order'];
  }

  int? baseHappiness;
  int? captureRate;
  List<FlavorTextEntries>? flavorTextEntries;
  List<Genera>? genera;
  bool? hasGenderDifferences;
  int? hatchCounter;
  int? id;
  bool? isBaby;
  bool? isLegendary;
  String? name;
  int? order;
}
class FlavorTextEntries {
  FlavorTextEntries({this.flavorText});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
  }

  String? flavorText;
}

class Genera {
  Genera({this.genus});

  Genera.fromJson(Map<String, dynamic> json) {
    genus = json['genus'];
  }

  String? genus;
}
