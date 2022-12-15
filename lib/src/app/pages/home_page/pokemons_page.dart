import 'package:flutter/material.dart';
import 'package:pokedex/src/app/pages/home_page/components/search_bar_component.dart';
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

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
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
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.00,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12)),
        ),
        title: const Text("PokeDex"),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
