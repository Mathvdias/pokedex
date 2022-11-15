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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const Banner(
          location: BannerLocation.topEnd,
          message: 'Matheus Dias',
          child: MyHomePage(title: 'PokeDex')),
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
          return GridView.builder(
              controller: viewModel.scrollController,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 4 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: viewModel.listAllPokemon.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Image.network(
                        viewModel.listAllPokemon[index].sprite,
                      ),
                      Text(viewModel.listAllPokemon[index].id),
                    ],
                  ),
                );
              });
        }),
      )),
    );
  }
}
