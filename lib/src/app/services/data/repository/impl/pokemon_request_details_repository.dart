import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../domain/models/pokemon_details.dart';
import '../../../domain/models/response/exception_response.dart';
import '../../providers/http_client_interface.dart';
import '../pokemon_request_details_repository_interface.dart';

class PokemonDetailsRepository implements IPokemonDetailsRequestRepository {
  final IRestClient client;
  PokemonDetailsRepository(this.client);

  @override
  Future<Result<PokemonDetailModel, PokemonException>> getPokemonDetail(
      String id) async {
    try {
      var json =
          await client.get('https://pokeapi.co/api/v2/pokemon-species/$id');
      final details = PokemonDetailModel.fromJson(json);
      return Success(details);
    } on DioError catch (e) {
      inspect('erro: $e');
      return Error(
        PokemonException(
          message: e.message,
        ),
      );
    }
  }
}
