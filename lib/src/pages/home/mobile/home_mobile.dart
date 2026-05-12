import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/app/text_theme.dart';

import '../../../viewmodels/pokemons_viewmodel.dart';
import 'components/card_pokemon.dart';
import 'components/search_bar_component.dart';

class HomeIsMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PokemonsViewModel viewModel;
  final ScrollController scrollController;

  const HomeIsMobile({
    super.key,
    required this.scaffoldKey,
    required this.viewModel,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokedexColors.cream,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PokedexColors.red,
        toolbarHeight: 56,
        title: Text(
          'POKÉDEX',
          style: GoogleFonts.pressStart2p(
            fontSize: 14,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: SearchBarComponent(),
          ),
        ),
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 3)),
      ),
      body: AnimatedBuilder(
        animation: viewModel.state,
        builder: (context, child) {
          final isLoading = viewModel.state.value == ResultState.loading;
          final itemCount = viewModel.listAllPokemon.length + (isLoading ? 1 : 0);

          return ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == viewModel.listAllPokemon.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Image.asset('assets/images/pokeLoad.gif', height: 60),
                  ),
                );
              }
              final poke = viewModel.listAllPokemon[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CardPokemonComponent(poke: poke, index: index),
              );
            },
          );
        },
      ),
    );
  }
}
