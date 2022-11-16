

import '../models/pokemon_details.dart';

abstract class IPokemonDetailsRepository {
  Future<PokemonDetailsModel> getPokemonDetail(int id);
}
