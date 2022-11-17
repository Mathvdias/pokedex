import 'package:pokedex/src/app/service/models/pokemon_details.dart';
import 'package:pokedex/src/app/service/providers/http_client_interface.dart';
import 'package:pokedex/src/app/service/repository/pokemon_details_repository_interface.dart';

import '../../models/pokemon_details_stats_model.dart';

class PokemonDetailsRepository implements IPokemonDetailsRepository {
  final IRestClient client;

  PokemonDetailsRepository(this.client);
  @override
  Future<PokemonDetailStatsModel> getPokemonDetail(String id) async {
    var json = await client.get('https://pokeapi.co/api/v2/pokemon/$id');

    return PokemonDetailStatsModel.fromJson(json);
  }
}


   // var jsonRedundance =
    //    await client.get('https://pokeapi.co/api/v2/pokemon-species/$id');