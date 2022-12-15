import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/common/extensions_strings.dart';

import '../../../states/pokemons_states.dart';
import 'text_formatter.dart';

class AboutPokemon extends StatelessWidget {
  final LoadedPokemonState poke;
  const AboutPokemon({
    Key? key,
    required this.poke,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormatterSpecs(
            description: 'Category',
            text: poke.pokemonDetails.species.toString(),
            model: poke,
          ),
          TextFormatterSpecs(
            model: poke,
            description: 'Height',
            text: '${poke.pokemonDetailsStats.height.toString().convert()} m',
          ),
          TextFormatterSpecs(
            model: poke,
            description: 'Weight',
            text: '${poke.pokemonDetailsStats.weight.toString().convert()} Kg',
          ),
          TextFormatterSpecs(
            model: poke,
            description: 'Abilities',
            text:
                '${toBeginningOfSentenceCase(poke.pokemonDetailsStats.ab1 ?? '')}\n${toBeginningOfSentenceCase(poke.pokemonDetailsStats.ab2 ?? '')}\n${toBeginningOfSentenceCase(poke.pokemonDetailsStats.ab3 ?? '')}',
          )
        ],
      ),
    );
  }
}
