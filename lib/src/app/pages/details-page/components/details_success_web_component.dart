import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/pages/details-page/components/page_component.dart';
import 'package:pokedex/src/app/pages/details-page/components/text_formatter_spec.dart';
import 'package:provider/provider.dart';

import '../../../common/color_tag.dart';
import '../../../viewmodels/pokemon_detail_viewmodel.dart';

class DetailSuccessWeb extends StatelessWidget {
  const DetailSuccessWeb({super.key});

  @override
  Widget build(BuildContext context) {
    String convertValue(value) {
      double convertedValue = value / 10;
      return convertedValue.toString();
    }

    final viewModel = context.watch<PokemonDetailViewModel>();
    return Wrap(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'imageHero: ${viewModel.pokemonDetails.id}',
                      child: FadeInImage.assetNetwork(
                        image: viewModel.pokemonDetailsStats.sprite
                            .toString(),
                        placeholder: 'assets/images/pokeLoad.gif',
                      ),
                    ),
                  ]),
            ),
            Expanded(
              flex: 1,
              child: Card(
                color: colorTag(viewModel
                    .pokemonDetailsStats.type1
                    .toString()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const PageComponent(percentHeight: .25, percentWidth: 3.8,),
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
            )
          ],
        ),
      ],
    );
  }
}
