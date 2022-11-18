import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/pages/details-page/components/page_component.dart';
import 'package:pokedex/src/app/pages/details-page/components/text_formatter_spec.dart';
import 'package:provider/provider.dart';

import '../../../common/color_tag.dart';
import '../../../viewmodels/pokemon_detail_viewmodel.dart';

class DetailsSuccessMobile extends StatelessWidget {
  const DetailsSuccessMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonDetailViewModel>();
    String convertValue(value) {
      double convertedValue = value / 10;
      return convertedValue.toString();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: 'imageHero: ${viewModel.pokemonDetails.id}',
            child: FadeInImage.assetNetwork(
              image: viewModel.pokemonDetailsStats.sprites!.other!
                  .officialArtwork!.frontDefault
                  .toString(),
              placeholder: 'assets/images/pokeLoad.gif',
            ),
          ),
          Card(
            color: colorTag(
                viewModel.pokemonDetailsStats.types![0].type!.name.toString()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const PageComponent(
                  percentHeight: 0.19,
                  percentWidth: .2,
                ),
                Card(
                  elevation: 10,
                  color: Colors.white60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormatterSpecs(
                            text:
                                "${convertValue(viewModel.pokemonDetailsStats.height)} m",
                            description: 'Height',
                          ),
                          TextFormatterSpecs(
                            text:
                                "${convertValue(viewModel.pokemonDetailsStats.weight)} kg",
                            description: 'Weight',
                          ),
                          const TextFormatterSpecs(
                            text: ' ♂ ♀ ',
                            description: 'Gender',
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormatterSpecs(
                            text: toBeginningOfSentenceCase(
                                viewModel.pokemonDetails.species)!,
                            description: 'Category',
                          ),
                          TextFormatterSpecs(
                            text: toBeginningOfSentenceCase(viewModel
                                .pokemonDetailsStats
                                .abilities?[0]
                                .ability!
                                .name)!,
                            description: 'Abilities',
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}