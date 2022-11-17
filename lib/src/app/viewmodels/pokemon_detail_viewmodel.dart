import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../service/models/pokemon_details_stats_model.dart';
import '../service/repository/impl/pokemon_details_repository.dart';

class PokemonDetailViewModel extends ChangeNotifier {
  final PokemonDetailsStatsRepository repository;

  PokemonDetailViewModel(this.repository);

  var pokemonDetail = PokemonDetailStatsModel();
  final state = ValueNotifier(ResultDetail.start);

  Future<void> fetchPokemonDetail(String id) async {
    state.value = ResultDetail.loading;
    try {
      pokemonDetail = await repository.getPokemonDetail(id);
      state.value = ResultDetail.success;
    } catch (e) {
      state.value = ResultDetail.error;
      inspect(e);
    }
    notifyListeners();
  }
}

enum ResultDetail { start, loading, success, error }
