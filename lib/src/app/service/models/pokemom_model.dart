class PokemonModel {
  var id;
  var name;
  var sprite;
  var type1;
  var type2;
  var imagelow;

  PokemonModel({
    this.id,
    this.name,
    this.sprite,
    this.type1,
    this.type2,
    this.imagelow,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    String pokeId = json['id'].toString();
    final List types = json['types'];
    if (types.length == 1) {
      return PokemonModel(
        id: pokeId,
        name: json['name'],
        sprite: json['sprites']['other']['official-artwork']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: null,
        imagelow: json['sprites']['front_default'],
      );
    } else {
      return PokemonModel(
        id: pokeId,
        name: json['name'],
        sprite: json['sprites']['other']['official-artwork']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: json['types'][1]['type']['name'],
        imagelow: json['sprites']['front_default'],
      );
    }
  }
}
