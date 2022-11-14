import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../service/models/pokemom_model.dart';
import '../service/repository/impl/pokemon_repository.dart';

class PokemonViewModel extends ChangeNotifier {
  PokemonViewModel(this.repository);

  var pokemonModel = PokemonModel();
  final PokemonRepository repository;

  Future fetchAll() async {
    try {
      pokemonModel = await repository.getPokemons();
    } catch (e) {
      inspect(e);
    }
    notifyListeners();
  }
}
