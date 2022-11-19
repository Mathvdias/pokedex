import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/common/set_icon.dart';
import 'package:pokedex/src/app/pages/details-page/components/page_component.dart';
import 'package:pokedex/src/app/pages/details-page/components/stats_bar_component.dart';
import 'package:pokedex/src/app/pages/details-page/components/text_formatter_spec.dart';
import 'package:pokedex/src/app/pages/details-page/components/type_card.dart';
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

    final stat = viewModel.pokemonDetailsStats.stats;
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: 'imageHero: ${viewModel.pokemonDetails.id}',
            child: FadeInImage.assetNetwork(
              image: viewModel.pokemonDetailsStats.sprite.toString(),
              placeholder: 'assets/images/pokeLoad.gif',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (viewModel.pokemonDetailsStats.type1 != null)
                TypeCard(
                  viewModel.pokemonDetailsStats.type1 ?? '',
                ),
              const SizedBox(
                width: 10,
              ),
              if (viewModel.pokemonDetailsStats.type2 != null)
                TypeCard(
                  viewModel.pokemonDetailsStats.type2 ?? '',
                )
            ],
          ),
          Card(
            color: colorTag(viewModel.pokemonDetailsStats.type1.toString()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageComponent(
                  percentHeight: (viewModel.pokemonDetails.flavorTextEntries![9]
                                  .flavorText!.length >
                              200 ||
                          viewModel.pokemonDetails.flavorTextEntries![9]
                                  .flavorText!.length >
                              200)
                      ? .26
                      : 0.195,
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
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    'Stats',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                          colorTag(viewModel.pokemonDetailsStats.type1 ?? ''),
                    ),
                  ),
                  const SizedBox(height: 15),
                  StatsBar(
                    label: 'HP',
                    value: stat![0].baseStat!.toDouble(),
                  ),
                  StatsBar(
                    label: 'Attack',
                    value: stat[1].baseStat!.toDouble(),
                  ),
                  StatsBar(
                    label: 'Defense',
                    value: stat[2].baseStat!.toDouble(),
                  ),
                  StatsBar(
                    label: 'X Attack',
                    value: stat[3].baseStat!.toDouble(),
                  ),
                  StatsBar(
                    label: 'X Defense',
                    value: stat[4].baseStat!.toDouble(),
                  ),
                  StatsBar(
                    label: 'Speed',
                    value: stat[5].baseStat!.toDouble(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
