import 'package:flutter/material.dart';

import '../../../states/pokemons_states.dart';
import 'stats_label_pokemon.dart';

class StatsPokemon extends StatelessWidget {
  final LoadedPokemonState poke;
  const StatsPokemon({
    Key? key,
    required this.poke,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Column(
          children: [
            StatsLabel(
                label: 'HP', value: poke.pokemonDetailsStats.hp!, model: poke),
            StatsLabel(
                label: 'ATK',
                value: poke.pokemonDetailsStats.attack!,
                model: poke),
            StatsLabel(
                label: 'DEF',
                value: poke.pokemonDetailsStats.defense!,
                model: poke),
            StatsLabel(
                label: 'SATK',
                value: poke.pokemonDetailsStats.spAttack!,
                model: poke),
            StatsLabel(
                label: 'SDEF',
                value: poke.pokemonDetailsStats.spDefense!,
                model: poke),
            StatsLabel(
                label: 'SPD',
                value: poke.pokemonDetailsStats.speed!,
                model: poke)
          ],
        ),
      ),
    );
  }
}
