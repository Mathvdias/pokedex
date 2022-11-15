import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/tag.dart';
import '../../../viewmodels/pokemon_viewmodel.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PokemonViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: viewModel,
      builder: ((context, child) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: height >= 1080 ? height / 3 : 0),
            child: GridView.builder(
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
                                  width: 60,
                                  height: 60,
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
                }),
          ),
        );
      }),
    );
  }
}
