import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../common/tag.dart';
import '../../../viewmodels/pokemon_viewmodel.dart';
import '../../details-page/details_page_pokemon.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PokemonViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: viewModel.state,
      builder: ((context, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PokemonListPokemonsGrid(width: width, viewModel: viewModel),
            viewModel.state.value == ResultState.loading
                ? Positioned(
                    bottom: 80,
                    child: Image.asset('assets/images/pokeLoad.gif'))
                : Container(),
          ],
        );
      }),
    );
  }
}

class PokemonListPokemonsGrid extends StatelessWidget {
  const PokemonListPokemonsGrid({
    Key? key,
    required this.width,
    required this.viewModel,
  }) : super(key: key);

  final double width;
  final PokemonViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width >= 1080 ? width / 4 : 10),
      child: GridView.builder(
          controller: viewModel.scrollController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 5 / 9,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: viewModel.listAllPokemon.length,
          itemBuilder: (BuildContext ctx, index) {
            return Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: (() => Navigator.pushNamed(
                          context,
                          DetailsPokemon.routeName,
                          arguments: (index + 1).toString(),
                        )),
                    child: Column(
                      children: [
                        const Spacer(),
                        Hero(
                          tag:
                              'imageHero: ${viewModel.listAllPokemon[index].id}',
                          child: Image(
                            image: CachedNetworkImageProvider(
                                viewModel.listAllPokemon[index].sprite,
                                maxWidth: 150,
                                maxHeight: 150),
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
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Text(
                          "N°${viewModel.listAllPokemon[index].id}",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          toBeginningOfSentenceCase(
                              viewModel.listAllPokemon[index].name)!,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TagWidget(
                              textType:
                                  viewModel.listAllPokemon[index].type1 ?? "",
                            ),
                            TagWidget(
                              textType:
                                  viewModel.listAllPokemon[index].type2 ?? "",
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
