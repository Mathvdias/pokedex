class PokemonDetailModel {
  PokemonDetailModel({
    required this.description,
    required this.species,
  });

  PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    int descIndex = 0;
    int speciesIndex = 0;
    List descList = json['flavor_text_entries'];
    for (int i = 0; i < descList.length; i++) {
      var desc = json['flavor_text_entries'][i]['language']['name'];
      if (desc == 'en') {
        descIndex = i;
      }
    }
    description = json['flavor_text_entries'][descIndex]['flavor_text'] ?? '';
    List speciesList = json['genera'];
    for (int i = 0; i < speciesList.length; i++) {
      var species = json['genera'][i]['language']['name'];
      if (species == 'en') {
        speciesIndex = i;
      }
    }
    species = json['genera'][speciesIndex]['genus'] ?? '';
  }

  String? description;
  String? species;
}
