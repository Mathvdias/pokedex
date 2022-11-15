import 'package:flutter/material.dart';
import 'package:pokedex/src/app/pages/home/components/app_bar.dart';
import '../../service/providers/impl/dio_client_provider.dart';
import '../../service/repository/impl/pokemon_list_repository.dart';
import '../../service/repository/impl/pokemon_repository.dart';
import '../../viewmodels/pokemon_viewmodel.dart';
import 'components/card_pokemon_component.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = PokemonViewModel(
      PokemonRepository(DioClient.withAuthBasic()),
      PokemonListRepository(DioClient.withAuthBasic()));

  @override
  void dispose() {
    viewModel.scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    viewModel.fetchAll();
    viewModel.scrollController = ScrollController();
    viewModel.scrollController.addListener(() {
      viewModel.infiniteScrolling();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: CardPokemon(viewModel: viewModel),
    );
  }
}
