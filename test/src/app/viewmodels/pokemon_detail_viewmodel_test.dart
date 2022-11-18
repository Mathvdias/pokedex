import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/app/service/models/pokemon_details_stats_model.dart';
import 'package:pokedex/src/app/service/providers/impl/dio_client_provider.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_details_repository.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_request_details_repository.dart';
import 'package:pokedex/src/app/viewmodels/pokemon_detail_viewmodel.dart';

void main() {
  final apiViewModel = PokemonDetailViewModel(
    PokemonDetailsStatsRepository(
      DioClient.withAuthBasic(),
    ),
    PokemonDetailsRepository(
      DioClient.withAuthBasic(),
    ),
  );
  test('Teste Category pokemon details', () async {
    await apiViewModel.fetchDetails('4');
    expect(apiViewModel.pokemonDetails.species, "Lizard Pokémon");
  });
  test('Teste Category pokemon description', () async {
    await apiViewModel.fetchDetails('4');
    expect(apiViewModel.pokemonDetails.flavorTextEntries![10].flavorText,
        "It has a preference for hot things.\nWhen it rains, steam is said to spout from\nthe tip of its tail.");
  });
  test('Teste Category pokemon evolution url', () async {
    await apiViewModel.fetchDetails('pichu');
    expect(apiViewModel.pokemonDetails.evolution,
        "https://pokeapi.co/api/v2/evolution-chain/10/");
  });
}
