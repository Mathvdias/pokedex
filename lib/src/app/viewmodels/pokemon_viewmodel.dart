import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex/src/app/service/models/pokemon_list_model.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_list_repository.dart';

import '../../app_config.dart';
import '../service/models/pokemom_model.dart';
import '../service/repository/impl/pokemon_repository.dart';

class PokemonViewModel extends ChangeNotifier {
  PokemonViewModel(this.repositoryPokemon, this.repositoryList);

  List<PokemonModel> listAllPokemon = <PokemonModel>[];
  final loading = ValueNotifier(true);
  int page1 = 1;
  int page2 = 12;
  int pageCount = 0;
  var pokemomListCount = PokemonListModel();
  var pokemonModel = PokemonModel();
  int reasonMath = 12;
  final PokemonListRepository repositoryList;
  final PokemonRepository repositoryPokemon;
  late final ScrollController scrollController;
  final state = ValueNotifier(ResultState.start);
  Future fetchList() async {
    try {
      pokemomListCount = await repositoryList.getAllPokemons(
          "${ApiURL.instance.base()}/pokemon?limit=12&offset=$pageCount");
    } catch (e) {
      inspect(e);
    }

    notifyListeners();
  }

  Future fetchAll() async {
    state.value = ResultState.loading;
    loading.value = true;
    fetchList();
    for (int index = page1; index < (page2 + 1); index++) {
      try {
        listAllPokemon.add(await repositoryPokemon.getPokemons(index));
      } catch (e) {
        state.value = ResultState.error;
        inspect(e);
      }
      state.value = ResultState.success;
    }
    pageCount = pageCount + reasonMath;
    page1 = page1 + reasonMath;
    page2 = page2 + reasonMath;
    loading.value = false;

    notifyListeners();
  }

  infiniteScrolling() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !loading.value) {
      state.value = ResultState.loading;
      fetchAll();
    }
    notifyListeners();
  }
}

enum ResultState { start, loading, success, error }
