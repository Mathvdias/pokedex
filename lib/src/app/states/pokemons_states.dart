import '../services/domain/models/pokemon_details.dart';
import '../services/domain/models/pokemon_details_stats_model.dart';
import 'pokemon_state.dart';

class StartPokemonState implements PokemonState {}

class LoadingPokemonState implements PokemonState {}

class LoadedPokemonState implements PokemonState {
  LoadedPokemonState(this.pokemonDetailsStats, this.pokemonDetails);

  final PokemonDetailStatsModel pokemonDetailsStats;
  final PokemonDetailModel pokemonDetails;
}

class ErrorPokemonState implements PokemonState {
  const ErrorPokemonState(this.message);

  final String message;
}
