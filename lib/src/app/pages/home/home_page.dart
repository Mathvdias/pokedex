import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../common/tag.dart';
import '../../service/providers/impl/dio_client_provider.dart';
import '../../service/repository/impl/pokemon_list_repository.dart';
import '../../service/repository/impl/pokemon_repository.dart';
import '../../viewmodels/pokemon_viewmodel.dart';

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
                  childAspectRatio: 5 / 8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: viewModel.listAllPokemon.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  elevation: 10,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Column(
                    children: [
                      Image(
                        image: CachedNetworkImageProvider(
                            viewModel.listAllPokemon[index].sprite,
                            maxWidth: 475,
                            maxHeight: 475),
                        loadingBuilder: ((context, child, progress) {
                          if (progress == null) {
                            return child;
                          }
                          return Center(
                            child: SizedBox(
                                child: Lottie.asset(
                                    'assets/images/poke_loading.json')),
                          );
                        }),
                      ),
                      Text(viewModel.listAllPokemon[index].id),
                      Text(viewModel.listAllPokemon[index].name),
                      TagWidget(
                        textType: viewModel.listAllPokemon[index].type1 ?? "",
                      ),
                      TagWidget(
                        textType: viewModel.listAllPokemon[index].type2 ?? "",
                      ),
                    ],
                  ),
                );
              });
        }),
      )),
    );
  }
}
