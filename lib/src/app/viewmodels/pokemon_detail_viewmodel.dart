import 'package:flutter/cupertino.dart';

import '../states/pokemon_state.dart';
import '../states/pokemons_states.dart';
import '../services/data/repository/impl/pokemon_details_repository.dart';
import '../services/data/repository/impl/pokemon_request_details_repository.dart';

class PokemonDetailViewModel extends ValueNotifier<PokemonState> {
  final PokemonDetailsRepository repositoryDetails;
  final PokemonDetailsStatsRepository repositoryStats;
  PokemonDetailViewModel(
    this.repositoryStats,
    this.repositoryDetails,
  ) : super(StartPokemonState());

  void emit(PokemonState state) => value = state;

  Future<void> fetch(String id) async {
    emit(LoadingPokemonState());
    final pokemonDetailsStats = await repositoryStats.getPokemonDetail(id);
    pokemonDetailsStats.when((pokemonDetailsStatsModel) async {
      final pokemonDetails = await repositoryDetails.getPokemonDetail(id);
      pokemonDetails.when((pokemonDetailModel) {
        emit(LoadedPokemonState(pokemonDetailsStatsModel, pokemonDetailModel));
      }, (e) {
        emit(ErrorPokemonState(e.message));
      });
    }, (e) {
      emit(ErrorPokemonState(e.message));
    });
    notifyListeners();
  }
}
