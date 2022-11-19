import 'package:pokedex/src/app/service/providers/http_client_interface.dart';
import 'package:pokedex/src/app/service/repository/pokemon_details_repository_interface.dart';

import '../../../../app_config.dart';
import '../../models/pokemon_details_stats_model.dart';

class PokemonDetailsStatsRepository implements IPokemonDetailsRepository {
  final IRestClient client;

  PokemonDetailsStatsRepository(this.client);
  @override
  Future<PokemonDetailStatsModel> getPokemonDetail(String id) async {
    var json = await client.get('${ApiURL.instance.base()}/pokemon/$id');

    return PokemonDetailStatsModel.fromJson(json);
  }
}


