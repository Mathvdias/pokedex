import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../services/data/repository/impl/pokemon_list_repository.dart';
import '../services/data/repository/impl/pokemon_repository.dart';
import '../services/domain/models/pokemom_model.dart';
import '../services/domain/models/pokemon_list_model.dart';
import '../states/pokemon_state.dart';
import '../states/pokemons_list.dart';

class PokemonsViewModel extends ValueNotifier<PokemonState> {
  final PokemonListRepository repositoryList;
  final PokemonRepository repositoryPokemon;
  PokemonsViewModel(this.repositoryPokemon, this.repositoryList)
      : super(StartPokemonsListState());

  List<PokemonModel> listAllPokemon = <PokemonModel>[];
  final ValueNotifier<bool> loading = ValueNotifier(true);
  final ValueNotifier<ResultState> state = ValueNotifier(ResultState.start);

  int currentPage = -1;

  final int pageSize = 12;

  void emit(PokemonState state) => value = state;
  Future fetchNextPage() async {
    currentPage++;
    state.value = ResultState.loading;
    loading.value = true;
    List<Results> listResults = await repositoryList.getResults(
        pageSize: pageSize, pageCount: currentPage);
    for (Results results in listResults) {
      try {
        listAllPokemon
            .add(await repositoryPokemon.getPokemonByUrl(results.url!));
      } catch (e) {
        state.value = ResultState.error;
        inspect(e);
        return;
      }
      state.value = ResultState.success;
    }
    loading.value = false;
    notifyListeners();
  }

  infiniteScrolling(ScrollController scrollController) {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !loading.value) {
      state.value = ResultState.loading;
      fetchNextPage();
    }
    notifyListeners();
  }
}

enum ResultState { start, loading, success, error }
