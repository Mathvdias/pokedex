import 'package:pokedex/src/app/service/models/pokemon_list_model.dart';
import 'package:pokedex/src/app/service/repository/pokemon_list_repository.dart';

import '../../providers/http_client_interface.dart';

class PokemonListRepository implements IPokemonListRepository {
  final IRestClient client;

  PokemonListRepository(this.client);
  @override
  Future<PokemonListModel> getAllPokemons(String page) async {
    var json = await client
        .get(page);
    return PokemonListModel.fromJson(json);
  }
}
