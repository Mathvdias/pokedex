import '../models/pokemon_details.dart';

abstract class IPokemonDetailsRequestRepository {
  Future<PokemonDetailModel> getPokemonDetail(String id);
}
