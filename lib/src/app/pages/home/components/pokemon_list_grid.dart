import 'package:flutter/material.dart';

import '../../../viewmodels/pokemon_viewmodel.dart';
import 'card_pokemon_details.dart';

class PokemonListGrid extends StatelessWidget {
  const PokemonListGrid({
    Key? key,
    required this.width,
    required this.viewModel,
  }) : super(key: key);

  final double width;
  final PokemonViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width >= 1080 ? width / 4 : 0),
        child: GridView.builder(
            controller: viewModel.scrollController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 5 / 9,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: viewModel.listAllPokemon.length,
            itemBuilder: (BuildContext ctx, index) {
              return CardPokemonDetailComponent(
                  viewModel: viewModel, index: index);
            }),
      ),
    );
  }
}
