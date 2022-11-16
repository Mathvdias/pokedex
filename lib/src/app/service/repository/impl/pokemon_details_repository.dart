import 'package:pokedex/src/app/service/models/pokemon_details.dart';
import 'package:pokedex/src/app/service/providers/http_client_interface.dart';
import 'package:pokedex/src/app/service/repository/pokemon_details_repository_interface.dart';

class PokemonDetailsRepository implements IPokemonDetailsRepository {
  final IRestClient client;

  PokemonDetailsRepository(this.client);
  @override
  Future<PokemonDetailsModel> getPokemonDetail(int id) async {
    var json = await client.get('https://pokeapi.co/api/v2/pokemon/$id');
    var jsonRedundance =
        await client.get('https://pokeapi.co/api/v2/pokemon-species/$id');
    return PokemonDetailsModel.fromJson(json, jsonRedundance);
  }
}
