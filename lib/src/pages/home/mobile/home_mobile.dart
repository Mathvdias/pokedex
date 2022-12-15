import 'package:flutter/material.dart';

import '../../../viewmodels/pokemons_viewmodel.dart';
import 'components/card_pokemon.dart';
import 'components/search_bar_component.dart';

class HomeIsMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PokemonsViewModel viewModel;
  final ScrollController scrollController;

  const HomeIsMobile({
    Key? key,
    required this.scaffoldKey,
    required this.viewModel,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 3,
        shadowColor: Colors.orange,
        elevation: 0,
        toolbarHeight: 60.2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12)),
        ),
        title: Text(
          "PokeDex",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 23),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 8),
            child: SearchBarComponent(),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: viewModel.state,
        builder: ((context, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
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
                    'assets/images/pokeLoad.gif',
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
