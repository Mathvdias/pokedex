import '../../../domain/models/pokemom_model.dart';
import '../../providers/http_client_interface.dart';
import '../pokemon_repository_interface.dart';

class PokemonRepository implements IPokemonRepository {
  final IRestClient client;

  PokemonRepository(this.client);

  @override
  Future<PokemonModel> getPokemonByUrl(String url) async {
    var json = await client.get(url);
    return PokemonModel.fromJson(json);
  }
}
