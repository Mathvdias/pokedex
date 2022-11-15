import 'package:pokedex/src/app/service/providers/http_client_interface.dart';
import 'package:pokedex/src/app/service/repository/pokemon_repository_interface.dart';

import '../../models/pokemom_model.dart';

class PokemonRepository implements IPokemonRepository {
  final IRestClient client;

  PokemonRepository(this.client);
  @override
  Future<PokemonModel> getPokemons(int id) async {
    var json = await client
        .get("https://pokeapi.co/api/v2/pokemon/$id");
    return PokemonModel.fromJson(json); 
  }
}
