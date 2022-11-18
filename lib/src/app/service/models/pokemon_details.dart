class PokemonDetailModel {
  PokemonDetailModel({
    this.baseHappiness,
    this.captureRate,
    this.flavorTextEntries,
    this.species,
    this.hasGenderDifferences,
    this.hatchCounter,
    this.id,
    this.name,
    this.order,
    this.evolution,
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
    species = json['genera'][7]['genus'] ?? '';
    hasGenderDifferences = json['has_gender_differences'];
    hatchCounter = json['hatch_counter'];
    id = json['id'];
    isLegendary = json['is_legendary'];
    name = json['name'];
    order = json['order'];
    evolution = json['evolution_chain']['url'];
  }

  int? baseHappiness;
  int? captureRate;
  List<FlavorTextEntries>? flavorTextEntries;
  String? species;
  bool? hasGenderDifferences;
  int? hatchCounter;
  int? id;
  bool? isBaby;
  bool? isLegendary;
  String? name;
  int? order;
  String? evolution;
}

class FlavorTextEntries {
  FlavorTextEntries({this.flavorText});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
  }

  String? flavorText;
}
