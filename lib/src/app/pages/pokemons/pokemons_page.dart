import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/pokemons_viewmodel.dart';

import 'components/card_pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    final viewModel = context.read<PokemonsViewModel>();
    viewModel.fetchNextPage();
    scrollController.addListener(() {
      viewModel.infiniteScrolling(scrollController);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = context.watch<PokemonsViewModel>();
    return Scaffold(
      body: AnimatedBuilder(
        animation: viewModel.state,
        builder: ((context, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ListView.builder(
                  controller: scrollController,
                  itemCount: viewModel.listAllPokemon.length,
                  itemBuilder: ((context, index) {
                    final poke = viewModel.listAllPokemon[index];
                    return CardPokemon(
                      poke: poke,
                      index: index,
                    );
                  })),
              if (viewModel.state.value == ResultState.loading)
                Positioned(
                  bottom: 80,
                  child: Image.asset(
                    'images/pika_loader.gif',
                    scale: 2 / 3,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
