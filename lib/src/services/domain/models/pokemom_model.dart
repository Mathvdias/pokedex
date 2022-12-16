class PokemonModel {
  int id;
  String name;
  String sprite;
  String type1;
  String? type2;
  String imagelow;
  int height;
  int weight;

  PokemonModel({
    required this.id,
    required this.name,
    required this.sprite,
    required this.type1,
    required this.type2,
    required this.imagelow,
    required this.height,
    required this.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    
    final List types = json['types'];
    if (types.length == 1) {
      return PokemonModel(
        id: json['id'],
        name: json['name'],
        sprite: json['sprites']['other']['official-artwork']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: null,
        imagelow: json['sprites']['front_default'],
        height: json['height'],
        weight: json['weight'],
      );
    } else {
      return PokemonModel(
        id: json['id'],
        name: json['name'],
        sprite: json['sprites']['other']['official-artwork']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: json['types'][1]['type']['name'],
        imagelow: json['sprites']['front_default'],
        height: json['height'],
        weight: json['weight'],
      );
    }
  }
}
