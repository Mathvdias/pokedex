import '../models/pokemom_model.dart';

abstract class IPokemonRepository {
  Future<PokemonModel> getPokemons(int id);
}
