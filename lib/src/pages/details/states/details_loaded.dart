import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/pages/details/components/about_pokemon.dart';
import 'package:pokedex/src/pages/details/components/moves_pokemon.dart';
import 'package:pokedex/src/pages/details/components/stats_pokemon.dart';

import 'package:pokedex/src/pages/details/mobile/loaded_mobile.dart';

import '../../../common/chip_component.dart';
import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';

class DetailsPagePokemonLoaded extends StatefulWidget {
  const DetailsPagePokemonLoaded({
    Key? key,
    required this.poke,
  }) : super(key: key);

  final LoadedPokemonState poke;

  @override
  State<DetailsPagePokemonLoaded> createState() =>
      _DetailsPagePokemonLoadedState();
}

class _DetailsPagePokemonLoadedState extends State<DetailsPagePokemonLoaded>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final day = date.day;
    final month = date.month;
    final year = date.year;
    final dateComplete = "$day/$month/$year";
    TabController tabController = TabController(length: 3, vsync: this);
    return LayoutBuilder(
        builder: ((BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return LoadedIsMobile(tabController: tabController, poke: widget.poke);
      } else {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            "PokeDex Data",
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
          )),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      toBeginningOfSentenceCase(
                          widget.poke.pokemonDetailsStats.name)!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 30,
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
                      "#${widget.poke.pokemonDetailsStats.id.toString()}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Card(
                      color:
                          setTypeColor(widget.poke.pokemonDetailsStats.type1!),
                      child: Image(
                        image: CachedNetworkImageProvider(
                          widget.poke.pokemonDetailsStats.sprite.toString(),
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
                    ),
                    Card(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Description',
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
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
                            height: 20,
                          ),
                          Text(
                            widget.poke.pokemonDetails.description.toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Types',
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
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
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.poke.pokemonDetailsStats.type1 != null)
                                Transform.scale(
                                  scale: 1.5,
                                  child: ChipComponent(
                                      poke: widget
                                          .poke.pokemonDetailsStats.type1!),
                                ),
                              SizedBox(
                                width: (widget.poke.pokemonDetailsStats.type2 !=
                                        null)
                                    ? 50
                                    : 0,
                              ),
                              if (widget.poke.pokemonDetailsStats.type2 != null)
                                Transform.scale(
                                  scale: 1.5,
                                  child: ChipComponent(
                                      poke: widget
                                          .poke.pokemonDetailsStats.type2!),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'About',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
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
                          AboutPokemon(poke: widget.poke),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          'Stats',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
                        StatsPokemon(poke: widget.poke),
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Text(
                                  'Moves',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
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
                                MovesPokemon(
                                  poke: widget.poke,
                                ),
                              ],
                            )))
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.start,
                children: <Widget>[
                  Image.network(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/${widget.poke.pokemonDetailsStats.id.toString()}.gif"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      "©2022 Matheus PokéDex Inc. TM.\nManaus - AM\n$dateComplete. "),
                ],
              ),
            ),
          ),
        );
      }
    }));
  }
}
