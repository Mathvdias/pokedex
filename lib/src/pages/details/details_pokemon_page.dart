import 'package:flutter/material.dart';
import 'package:pokedex/src/states/pokemon_state.dart';

import 'package:provider/provider.dart';

import '../../states/pokemons_states.dart';
import '../../viewmodels/pokemon_detail_viewmodel.dart';
import 'states/details_error.dart';
import 'states/details_loaded.dart';
import 'states/details_loading.dart';
import 'states/details_start.dart';

class DetailsPokemon extends StatefulWidget {
  const DetailsPokemon({
    Key? key,
  }) : super(key: key);

  static const routeName = '/details';

  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon> {
  TabController? controller;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_isInit) {
        final pokeId = ModalRoute.of(context)?.settings.arguments as String;
        Provider.of<PokemonDetailViewModel>(context, listen: false)
            .fetch(pokeId)
            .then((_) {});
      }
      _isInit = false;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PokemonDetailViewModel viewModel =
        context.watch<PokemonDetailViewModel>();
    return Scaffold(
      body: AnimatedBuilder(
          animation: viewModel,
          builder: (_, child) {
            if (viewModel.value is StartPokemonState) {
              return const DetailsPagePokemonStart();
            }
            if (viewModel.value is LoadingPokemonState) {
              return const DetailsPagePokemonLoading();
            }
            if (viewModel.value is LoadedPokemonState) {
              return DetailsPagePokemonLoaded(
                  loadedPokemonState: viewModel.value as LoadedPokemonState);
            }
            if (viewModel.value is ErrorPokemonState) {
              return DetailsPagePokemonError(
                  errorPokemonState: viewModel.value as ErrorPokemonState);
            }
            return const Text("Tipo de estado não definido");
          }),
    );
  }
}
