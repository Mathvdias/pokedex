import '../models/pokemon_details_stats_model.dart';

abstract class IPokemonDetailsRepository {
  Future<PokemonDetailStatsModel> getPokemonDetail(String id);
}
