import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../states/pokemons_states.dart';
import '../../viewmodels/pokemon_detail_viewmodel.dart';
import 'states/details_error.dart';
import 'states/details_loaded.dart';
import 'states/details_loading.dart';
import 'states/details_start.dart';

class DetailsPokemon extends StatefulWidget {
  const DetailsPokemon({super.key});

  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon> {
  TabController? controller;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _isInit = false;
      final pokeId = GoRouterState.of(context).pathParameters['id']!;
      Provider.of<PokemonDetailViewModel>(context, listen: false).fetch(pokeId);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PokemonDetailViewModel viewModel = context.watch<PokemonDetailViewModel>();
    return Scaffold(
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (_, child) {
          if (viewModel.value is StartPokemonState) return const DetailsPagePokemonStart();
          if (viewModel.value is LoadingPokemonState) return const DetailsPagePokemonLoading();
          if (viewModel.value is LoadedPokemonState) {
            return DetailsPagePokemonLoaded(poke: viewModel.value as LoadedPokemonState);
          }
          if (viewModel.value is ErrorPokemonState) {
            return DetailsPagePokemonError(errorPokemonState: viewModel.value as ErrorPokemonState);
          }
          return const Center(child: Text('Estado não definido'));
        },
      ),
    );
  }
}
