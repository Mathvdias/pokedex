import '../services/domain/models/pokemom_model.dart';
import 'pokemon_state.dart';

class StartPokemonsListState implements PokemonState {}

class LoadingPokemonsListState implements PokemonState {}

class LoadedPokemonsListState implements PokemonState {
  LoadedPokemonsListState(this.listAllPokemon);

  final List<PokemonModel> listAllPokemon;
}

class ErrorPokemonListState implements PokemonState {
  const ErrorPokemonListState(this.message);

  final String message;
}
