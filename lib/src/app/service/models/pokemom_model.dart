class PokemonModel {
  PokemonModel({ this.name, this.url});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

   String? name;
   String? url;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
