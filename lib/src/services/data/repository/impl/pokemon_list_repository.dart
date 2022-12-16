import '../../../domain/models/pokemon_list_model.dart';
import '../../providers/http_client_interface.dart';
import '../pokemon_list_repository.dart';

class PokemonListRepository implements IPokemonListRepository {
  final IRestClient client;

  PokemonListRepository(this.client);
  @override
  Future<PokemonListModel> getAllPokemons(String page) async {
    var json = await client.get(page);
    return PokemonListModel.fromJson(json);
  }

  Future<List<Results>> getResults(
      {required int pageSize, required int pageCount}) async {
    String url =
        "https://pokeapi.co/api/v2/pokemon?limit=$pageSize&offset=${pageCount * pageSize}";
    var results = <Results>[];
    var json = await client.get(url);
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
    return results;
  }
}
