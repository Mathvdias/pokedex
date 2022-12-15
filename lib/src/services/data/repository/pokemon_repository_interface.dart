import '../../domain/models/pokemom_model.dart';

abstract class IPokemonRepository {
  Future<PokemonModel> getPokemonByUrl(String url);
}
