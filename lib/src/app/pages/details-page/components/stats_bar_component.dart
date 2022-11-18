import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/color_tag.dart';
import '../../../viewmodels/pokemon_detail_viewmodel.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String label;
  final double value;
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonDetailViewModel>();
    convertValue(value) {
      double initValue = value;
      return initValue.toStringAsFixed(0);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: colorTag(viewModel.pokemonDetailsStats.type1 ?? ''),
            ),
          ),
          const Spacer(),
          Text(
            convertValue(value),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: colorTag(viewModel.pokemonDetailsStats.type1 ?? ''),
            ),
          ),
          Container(
            width: 150,
            height: 10,
            margin: const EdgeInsets.only(left: 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                    colorTag(viewModel.pokemonDetailsStats.type1 ?? '')),
                value: value / 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
