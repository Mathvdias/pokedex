import 'dart:developer';

import 'package:intercepted_http/intercepted_http.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../domain/models/pokemon_details_stats_model.dart';
import '../../../domain/models/response/exception_response.dart';
import '../../providers/http_client_interface.dart';
import '../pokemon_details_repository_interface.dart';

class PokemonDetailsStatsRepository implements IPokemonDetailsRepository {
  final IRestClient client;

  PokemonDetailsStatsRepository(this.client);

  @override
  Future<Result<PokemonDetailStatsModel, PokemonException>> getPokemonDetail(
      String id) async {
    try {
      final json = await client.get('https://pokeapi.co/api/v2/pokemon/$id');
      return Success(PokemonDetailStatsModel.fromJson(json));
    } on HttpClientException catch (e) {
      inspect(e);
      return Error(PokemonException(message: e.message ?? 'Erro ${e.statusCode}'));
    } catch (e) {
      inspect(e);
      return Error(PokemonException(message: e.toString()));
    }
  }
}
