import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../service/models/pokemon_details.dart';
import '../service/models/pokemon_details_stats_model.dart';
import '../service/repository/impl/pokemon_details_repository.dart';
import '../service/repository/impl/pokemon_request_details_repository.dart';

class PokemonDetailViewModel extends ChangeNotifier {
  PokemonDetailViewModel(this.repositoryStats, this.repositoryDetails);

  var pokemonDetails = PokemonDetailModel();
  var pokemonDetailsStats = PokemonDetailStatsModel();
  final PokemonDetailsRepository repositoryDetails;
  final PokemonDetailsStatsRepository repositoryStats;
  final state = ValueNotifier(ResultDetailStats.start);
  final stateDetail = ValueNotifier(ResultDetail.start);

  Future<void> fetchPokemonDetail(String id) async {
    state.value = ResultDetailStats.loading;
    try {
      pokemonDetailsStats = await repositoryStats.getPokemonDetail(id);
      state.value = ResultDetailStats.success;
    } catch (e) {
      state.value = ResultDetailStats.error;
      inspect(e);
    }
    notifyListeners();
  }

  Future<void> fetchDetails(String id) async {
    stateDetail.value = ResultDetail.loading;
    try {
      pokemonDetails = await repositoryDetails.getPokemonDetail(id);
      stateDetail.value = ResultDetail.success;
    } catch (e) {
      stateDetail.value = ResultDetail.error;
      inspect(e);
    }
    notifyListeners();
  }
}

enum ResultDetailStats { start, loading, success, error }

enum ResultDetail { start, loading, success, error }
