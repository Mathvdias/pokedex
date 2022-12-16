import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/chip_component.dart';
import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';
import '../components/about_pokemon.dart';
import '../components/moves_pokemon.dart';
import '../components/stats_pokemon.dart';

class LoadedIsMobile extends StatelessWidget {
  final TabController tabController;
  final LoadedPokemonState poke;
  const LoadedIsMobile({
    super.key,
    required this.tabController,
    required this.poke,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              toBeginningOfSentenceCase(poke.pokemonDetailsStats.name)!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 7,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "#${poke.pokemonDetailsStats.id.toString()}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 15),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: CachedNetworkImageProvider(
              poke.pokemonDetailsStats.sprite.toString(),
              maxHeight: 350,
              maxWidth: 350,
            ),
            loadingBuilder: ((context, child, progress) {
              if (progress == null) {
                return child;
              }
              return Center(
                child: Image.asset('assets/images/pokeLoad.gif'),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (poke.pokemonDetailsStats.type1 != null)
                ChipComponent(poke: poke.pokemonDetailsStats.type1!),
              const SizedBox(
                width: 5,
              ),
              if (poke.pokemonDetailsStats.type2 != null)
                ChipComponent(poke: poke.pokemonDetailsStats.type2!)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: FittedBox(
              child: Text(
                poke.pokemonDetails.description.toString(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              //  width: double.maxFinite,
              height: 30,
              child: TabBar(
                splashBorderRadius: BorderRadius.circular(
                  25.0,
                ),
                unselectedLabelColor:
                    setTypeColor(poke.pokemonDetailsStats.type1!),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: setTypeColor(poke.pokemonDetailsStats.type1!),
                ),
                labelColor: Colors.white,
                controller: tabController,
                tabs: const [
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Stats',
                  ),
                  Tab(
                    text: 'Moves',
                  )
                ],
                isScrollable: true,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              AboutPokemon(
                poke: poke,
              ),
              StatsPokemon(
                poke: poke,
              ),
              MovesPokemon(
                poke: poke,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
