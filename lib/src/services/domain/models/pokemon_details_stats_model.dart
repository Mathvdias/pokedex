class PokemonDetailStatsModel {
  PokemonDetailStatsModel({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.spAttack,
    required this.spDefense,
    required this.abilities,
    required this.ab1,
    required this.ab2,
    required this.ab3,
    required this.height,
    required this.id,
    required this.name,
    required this.order,
    required this.sprite,
    required this.types,
    required this.type1,
    required this.type2,
    required this.weight,
    required this.moves,
  });

  PokemonDetailStatsModel.fromJson(Map<String, dynamic> json) {
    hp = json['stats'][0]['base_stat'];
    attack = json['stats'][1]['base_stat'];
    defense = json['stats'][2]['base_stat'];
    spAttack = json['stats'][3]['base_stat'];
    spDefense = json['stats'][4]['base_stat'];
    speed = json['stats'][5]['base_stat'];
    abilities = json['abilities'];
    ab1 = (abilities?.length != null && abilities!.isNotEmpty)
        ? json['abilities'][0]['ability']['name']
        : null;
    ab2 = (abilities!.length > 1)
        ? json['abilities'][1]['ability']['name']
        : null;

    ab3 =
        abilities?.length == 3 ? json['abilities'][2]['ability']['name'] : null;
    baseExperience = json['base_experience'];
    height = json['height'] ?? "";
    id = json['id'];
    name = json['name'];
    order = json['order'];
    sprite = json['sprites']['other']['official-artwork']['front_default'];
    types = json['types'];
    type1 = json['types'][0]['type']['name'] ?? "";
    type2 = types?.length == 2 ? json['types'][1]['type']['name'] : null;
    weight = json['weight'] ?? "";
    List movesList = json['moves'];
    List tempMovesList = [];
    for (int i = 0; i < movesList.length; i++) {
      var moves = json['moves'][i]['move']['name'];
      tempMovesList.add(moves);
    }
    moves = tempMovesList;
  }
  int? hp;
  int? attack;
  int? defense;
  int? spAttack;
  int? spDefense;
  int? speed;
  List? abilities;
  String? ab1;
  String? ab2;
  String? ab3;
  int? baseExperience;
  int? height;
  int? id;
  bool? isDefault;
  String? locationAreaEncounters;
  String? name;
  int? order;
  String? sprite;
  List? types;
  String? type1;
  String? type2;
  int? weight;
  List? moves;
}

class Abilities {
  Abilities({this.isHidden, this.slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  bool? isHidden;
  int? slot;
}

class Sprites {
  Sprites({
    this.other,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? Other.fromJson(json['other']) : null;
  }

  Other? other;
}

class Other {
  Other({this.officialArtwork});

  Other.fromJson(Map<String, dynamic> json) {
    officialArtwork = json['official-artwork'] != null
        ? OfficialArtwork.fromJson(json['official-artwork'])
        : null;
  }

  OfficialArtwork? officialArtwork;
}

class OfficialArtwork {
  OfficialArtwork({this.frontDefault});

  OfficialArtwork.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  String? frontDefault;
}
