import 'dart:developer';

import 'package:intercepted_http/intercepted_http.dart';
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
      final json = await client.get('https://pokeapi.co/api/v2/pokemon-species/$id');
      return Success(PokemonDetailModel.fromJson(json));
    } on HttpClientException catch (e) {
      inspect(e);
      return Error(PokemonException(message: e.message ?? 'Erro ${e.statusCode}'));
    } catch (e) {
      inspect(e);
      return Error(PokemonException(message: e.toString()));
    }
  }
}
