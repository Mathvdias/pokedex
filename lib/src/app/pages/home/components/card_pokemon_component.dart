import 'package:flutter/material.dart';

import '../../../viewmodels/pokemon_viewmodel.dart';
import 'card_pokemon_details.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PokemonViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: viewModel.state,
      builder: ((context, child) {
        return PokemonListPokemonsGrid(width: width, viewModel: viewModel);
      }),
    );
  }
}

class PokemonListPokemonsGrid extends StatelessWidget {
  const PokemonListPokemonsGrid({
    Key? key,
    required this.width,
    required this.viewModel,
  }) : super(key: key);

  final double width;
  final PokemonViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width >= 1080 ? width / 4 : 0),
        child: GridView.builder(
            controller: viewModel.scrollController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 5 / 9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: viewModel.listAllPokemon.length,
            itemBuilder: (BuildContext ctx, index) {
              return CardPokemonDetailComponent(
                  viewModel: viewModel, index: index);
            }),
      ),
    );
  }
}
