import 'package:multiple_result/multiple_result.dart';

import '../../domain/models/pokemon_details.dart';
import '../../domain/models/response/exception_response.dart';

abstract class IPokemonDetailsRequestRepository {
  Future<Result<PokemonDetailModel, PokemonException>> getPokemonDetail(
      String id);
}
