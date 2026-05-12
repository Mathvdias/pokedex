import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/common/set_icon.dart';

import 'colors/map_card_color.dart';

class ChipComponent extends StatelessWidget {
  const ChipComponent({super.key, required this.poke});

  final String poke;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: setTypeColor(poke),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            setTypeIcon(poke),
            style: const TextStyle(
              fontFamily: 'PokeGoTypes',
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            poke.toUpperCase(),
            style: GoogleFonts.pressStart2p(
              fontSize: 6,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
