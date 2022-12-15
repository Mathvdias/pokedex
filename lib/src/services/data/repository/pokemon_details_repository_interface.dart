import 'package:multiple_result/multiple_result.dart';

import '../../domain/models/pokemon_details_stats_model.dart';
import '../../domain/models/response/exception_response.dart';

abstract class IPokemonDetailsRepository {
  Future<Result<PokemonDetailStatsModel, PokemonException>> getPokemonDetail(String id);
}
