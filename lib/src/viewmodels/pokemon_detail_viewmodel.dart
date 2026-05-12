import 'package:flutter/cupertino.dart';
import 'package:multiple_result/multiple_result.dart';

import '../services/data/repository/impl/pokemon_details_repository.dart';
import '../services/data/repository/impl/pokemon_request_details_repository.dart';
import '../services/domain/models/pokemon_details.dart';
import '../services/domain/models/pokemon_details_stats_model.dart';
import '../states/pokemon_state.dart';
import '../states/pokemons_states.dart';

class PokemonDetailViewModel extends ValueNotifier<PokemonState> {
  final PokemonDetailsRepository repositoryDetails;
  final PokemonDetailsStatsRepository repositoryStats;

  PokemonDetailViewModel(this.repositoryStats, this.repositoryDetails)
      : super(StartPokemonState());

  void emit(PokemonState state) => value = state;

  Future<void> fetch(String id) async {
    emit(LoadingPokemonState());

    // Parallel: both endpoints fire at the same time
    final (statsResult, detailsResult) = await (
      repositoryStats.getPokemonDetail(id),
      repositoryDetails.getPokemonDetail(id),
    ).wait;

    PokemonDetailStatsModel? stats;
    PokemonDetailModel? details;
    String? error;

    statsResult.when(
      (s) => stats = s,
      (e) => error = e.message,
    );

    if (error == null) {
      detailsResult.when(
        (d) => details = d,
        (e) => error = e.message,
      );
    }

    if (error != null) {
      emit(ErrorPokemonState(error!));
    } else {
      emit(LoadedPokemonState(stats!, details!));
    }

    notifyListeners();
  }
}
