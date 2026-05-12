import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../services/data/repository/impl/pokemon_list_repository.dart';
import '../services/data/repository/impl/pokemon_repository.dart';
import '../services/domain/models/pokemom_model.dart';
import '../states/pokemon_state.dart';
import '../states/pokemons_list.dart';

class PokemonsViewModel extends ValueNotifier<PokemonState> {
  final PokemonListRepository repositoryList;
  final PokemonRepository repositoryPokemon;

  PokemonsViewModel(this.repositoryPokemon, this.repositoryList)
      : super(StartPokemonsListState());

  List<PokemonModel> listAllPokemon = <PokemonModel>[];
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<ResultState> state = ValueNotifier(ResultState.start);

  int currentPage = -1;
  final int pageSize = 20;

  void emit(PokemonState s) => value = s;

  Future<void> fetchNextPage() async {
    if (loading.value) return;

    currentPage++;
    loading.value = true;
    state.value = ResultState.loading;

    try {
      final listResults = await repositoryList.getResults(
        pageSize: pageSize,
        pageCount: currentPage,
      );

      // Parallel: all Pokémon fetched simultaneously instead of sequential loop
      final fetched = await Future.wait(
        listResults.map((r) => repositoryPokemon.getPokemonByUrl(r.url!)),
      );

      listAllPokemon.addAll(fetched);
      state.value = ResultState.success;
    } catch (e) {
      state.value = ResultState.error;
      currentPage--;
      inspect(e);
    } finally {
      loading.value = false;
      notifyListeners();
    }
  }

  void infiniteScrolling(ScrollController scrollController) {
    if (loading.value) return;
    final pos = scrollController.position;
    // Trigger 300px before the end for a smoother experience
    if (pos.pixels >= pos.maxScrollExtent - 300) {
      fetchNextPage();
    }
  }
}

enum ResultState { start, loading, success, error }
