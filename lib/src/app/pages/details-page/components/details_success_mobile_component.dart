import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/pages/details-page/components/page_component.dart';
import 'package:pokedex/src/app/pages/details-page/components/stats_bar_component.dart';
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

    final stat = viewModel.pokemonDetailsStats.stats;
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
                      color: colorTag(
                          viewModel.pokemonDetailsStats.types?[0].type?.name ??
                              ''),
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
                    label: 'Special Attack',
                    value: stat[3].baseStat!.toDouble(),
                  ),
                  StatsBar(
                    label: 'Special Defense',
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
