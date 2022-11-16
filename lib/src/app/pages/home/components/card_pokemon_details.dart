import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../common/tag.dart';
import '../../../viewmodels/pokemon_viewmodel.dart';
import 'click_card_pokemon_component.dart';

class CardPokemonDetailComponent extends StatelessWidget {
  const CardPokemonDetailComponent({
    Key? key,
    required this.viewModel,
    required this.index,
  }) : super(key: key);

  final PokemonViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: ClickCardPokemon(
        viewModel: viewModel,
        index: index,
        function: (() => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Container(
                      child: Text((index + 1).toString()),
                    )))),
      ),
    );
  }
}
