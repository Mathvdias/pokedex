import 'dart:developer';

import 'package:dio/dio.dart';
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
      var json = await client.get('https://pokeapi.co/api/v2/pokemon/$id');
      final stats = PokemonDetailStatsModel.fromJson(json);
      return Success(stats);
    } on DioError catch (e) {
      inspect(e);
      return Error(
        PokemonException(
          message: e.message,
        ),
      );
    }
  }
}
