import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/app/text_theme.dart';

import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';

class TextFormatterSpecs extends StatelessWidget {
  const TextFormatterSpecs({
    super.key,
    required this.description,
    required this.text,
    required this.model,
  });

  final String description;
  final String text;
  final LoadedPokemonState model;

  @override
  Widget build(BuildContext context) {
    final typeColor = setTypeColor(model.pokemonDetailsStats.type1 ?? '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              description.toUpperCase(),
              style: GoogleFonts.pressStart2p(fontSize: 7, color: typeColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.vt323(fontSize: 20, color: PokedexColors.dark, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
