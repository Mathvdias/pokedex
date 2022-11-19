import 'package:pokedex/src/app/service/models/pokemon_details.dart';
import 'package:pokedex/src/app_config.dart';

import '../../providers/http_client_interface.dart';
import '../pokemon_request_details_repository_interface.dart';

class PokemonDetailsRepository implements IPokemonDetailsRequestRepository {
  final IRestClient client;
  PokemonDetailsRepository(this.client);

  @override
  Future<PokemonDetailModel> getPokemonDetail(String id) async {
    var json =
        await client.get('${ApiURL.instance.base()}/pokemon-species/$id');

    return PokemonDetailModel.fromJson(json);
  }
}
