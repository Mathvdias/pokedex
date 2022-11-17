import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../viewmodels/pokemon_detail_viewmodel.dart';

class TextListFormatter extends StatelessWidget {
  const TextListFormatter(
      {super.key, required this.description, required this.viewModel});
  final String description;
  final PokemonDetailViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(toBeginningOfSentenceCase(
            viewModel.pokemonDetailsStats.abilities?[0].ability!.name)!),
        viewModel.pokemonDetailsStats.abilities?[1].ability!.name == null
            ? Container()
            : Text(toBeginningOfSentenceCase(
                viewModel.pokemonDetailsStats.abilities?[1].ability!.name)!),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
