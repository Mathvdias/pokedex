import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';
import 'about_pokemon.dart';
import 'moves_pokemon.dart';
import 'stats_pokemon.dart';

class DetailsPagePokemonLoaded extends StatefulWidget {
  const DetailsPagePokemonLoaded({
    Key? key,
    required this.loadedPokemonState,
  }) : super(key: key);

  final LoadedPokemonState loadedPokemonState;

  @override
  State<DetailsPagePokemonLoaded> createState() =>
      _DetailsPagePokemonLoadedState();
}

class _DetailsPagePokemonLoadedState extends State<DetailsPagePokemonLoaded>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              toBeginningOfSentenceCase(
                  widget.loadedPokemonState.pokemonDetailsStats.name)!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "#${widget.loadedPokemonState.pokemonDetailsStats.id.toString()}",
              style: Theme.of(context).textTheme.titleLarge,
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
              widget.loadedPokemonState.pokemonDetailsStats.sprite.toString(),
              maxHeight: 250,
              maxWidth: 250,
            ),
            loadingBuilder: ((context, child, progress) {
              if (progress == null) {
                return child;
              }
              return Center(
                child: Image.asset('images/poke.gif'),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.loadedPokemonState.pokemonDetailsStats.type1 != null)
                Chip(
                  backgroundColor: setTypeColor(
                      widget.loadedPokemonState.pokemonDetailsStats.type1!),
                  label: Text(
                    toBeginningOfSentenceCase(
                        widget.loadedPokemonState.pokemonDetailsStats.type1 ??
                            '')!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white, fontSize: 12),
                  ),
                ),
              const SizedBox(
                width: 5,
              ),
              if (widget.loadedPokemonState.pokemonDetailsStats.type2 != null)
                Chip(
                  backgroundColor: setTypeColor(
                      widget.loadedPokemonState.pokemonDetailsStats.type2!),
                  label: Text(
                    toBeginningOfSentenceCase(
                        widget.loadedPokemonState.pokemonDetailsStats.type2 ??
                            '')!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white, fontSize: 12),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                widget.loadedPokemonState.pokemonDetails.description.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
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
                unselectedLabelColor: setTypeColor(
                    widget.loadedPokemonState.pokemonDetailsStats.type1!),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: setTypeColor(
                      widget.loadedPokemonState.pokemonDetailsStats.type1!),
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
                poke: widget.loadedPokemonState,
              ),
              StatsPokemon(
                poke: widget.loadedPokemonState,
              ),
              MovesPokemon(
                poke: widget.loadedPokemonState,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
