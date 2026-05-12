import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';

class MovesPokemon extends StatelessWidget {
  const MovesPokemon({super.key, required this.poke});

  final LoadedPokemonState poke;

  @override
  Widget build(BuildContext context) {
    final typeColor = setTypeColor(poke.pokemonDetailsStats.type1.toString());

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: poke.pokemonDetailsStats.moves!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: typeColor,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Text(
            (toBeginningOfSentenceCase(
                  poke.pokemonDetailsStats.moves![index].toString(),
                ) ??
                '').toUpperCase(),
            style: GoogleFonts.pressStart2p(
              fontSize: 6,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
