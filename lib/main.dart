import 'package:flutter/material.dart';
import 'package:pokedex/src/app/service/providers/impl/dio_client_provider.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_list_repository.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_repository.dart';
import 'package:pokedex/src/app/viewmodels/pokemon_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
  void initState() {
    viewModel.fetchAll();
    viewModel.scrollController = ScrollController();
    viewModel.scrollController.addListener(() {
      viewModel.infiniteScrolling();
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: AnimatedBuilder(
        animation: viewModel,
        builder: ((context, child) {
          return ListView.builder(
            controller: viewModel.scrollController,
            itemBuilder: ((context, index) {
              return Image.network(
                viewModel.listAllPokemon[index].sprite,
              );
            }),
            itemCount: viewModel.listAllPokemon.length,
          );
        }),
      )),
    );
  }
}
