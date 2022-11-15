import 'package:pokedex/src/app/service/models/pokemon_list_model.dart';

abstract class IPokemonListRepository {
  Future<PokemonListModel> getAllPokemons(String page);
}
