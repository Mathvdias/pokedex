import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/app/text_theme.dart';

import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';

class StatsLabel extends StatelessWidget {
  const StatsLabel({
    super.key,
    required this.label,
    required this.value,
    required this.model,
  });

  final String label;
  final int value;
  final LoadedPokemonState model;

  Color _barColor() {
    if (value >= 100) return const Color(0xFF4CAF50);
    if (value >= 70) return const Color(0xFF8BC34A);
    if (value >= 50) return const Color(0xFFFFD700);
    return const Color(0xFFE3350D);
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = setTypeColor(model.pokemonDetailsStats.type1 ?? '');
    final barFill = (value / 255).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              label,
              style: GoogleFonts.pressStart2p(fontSize: 7, color: typeColor),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text(
              value.toString().padLeft(3),
              textAlign: TextAlign.right,
              style: GoogleFonts.vt323(fontSize: 20, color: PokedexColors.dark, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                // Background track (pixel)
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
                // Fill bar
                FractionallySizedBox(
                  widthFactor: barFill,
                  child: Container(
                    height: 10,
                    color: _barColor(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
