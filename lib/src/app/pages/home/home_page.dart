import 'package:flutter/material.dart';
import 'package:pokedex/src/app/pages/home/components/app_bar.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/pokemon_viewmodel.dart';
import 'components/card_pokemon_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final viewModel = context.read<PokemonViewModel>();
    viewModel.fetchAll();
    viewModel.scrollController = ScrollController();
    viewModel.scrollController.addListener(() {
      viewModel.infiniteScrolling();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonViewModel>();
    return Scaffold(
        appBar: const AppBarComponent(),
        body: CardPokemon(viewModel: viewModel));
  }

  @override
  void dispose() {
    final viewModel = context.read<PokemonViewModel>();
    viewModel.scrollController.dispose();
    super.dispose();
  }
}
