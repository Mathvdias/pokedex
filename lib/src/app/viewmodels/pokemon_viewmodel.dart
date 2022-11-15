import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex/src/app/service/models/pokemon_list_model.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_list_repository.dart';

import '../service/models/pokemom_model.dart';
import '../service/repository/impl/pokemon_repository.dart';

class PokemonViewModel extends ChangeNotifier {
  PokemonViewModel(this.repositoryPokemon, this.repositoryList);

  var pokemonModel = PokemonModel();
  var pokemomListCount = PokemonListModel();
  List<PokemonModel> listAllPokemon = <PokemonModel>[];

  late final ScrollController scrollController;

  final PokemonRepository repositoryPokemon;
  final PokemonListRepository repositoryList;

  int pageCount = 0;
  int page1 = 1;
  int page2 = 12;
  int reasonMath = 12;
  Future fetchList() async {
    try {
      pokemomListCount = await repositoryList.getAllPokemons(
          "https://pokeapi.co/api/v2/pokemon?limit=12&offset=$pageCount");
    } catch (e) {
      inspect(e);
    }
    notifyListeners();
  }

  Future fetchAll() async {
    fetchList();
    try {
      for (int index = page1; index < (page2 + 1); index++) {
        listAllPokemon.add(await repositoryPokemon.getPokemons(index));
      }
    } catch (e) {
      inspect(e);
    }
    pageCount = pageCount + reasonMath;
    page1 = page1 + reasonMath;
    page2 = page2 + reasonMath;
    notifyListeners();
  }

  infiniteScrolling() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchAll();
    }
    notifyListeners();
  }
}
