import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../common/tag.dart';
import '../../../viewmodels/pokemon_viewmodel.dart';

class CardPokemonDetailComponent extends StatelessWidget {
  const CardPokemonDetailComponent({
    Key? key,
    required this.viewModel,
    required this.index,
  }) : super(key: key);

  final PokemonViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        children: [
          const Spacer(),
          Image(
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
                    child: Lottie.asset('assets/images/poke_loading.json')),
              );
            }),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            "N°${viewModel.listAllPokemon[index].id}",
            style: GoogleFonts.poppins(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          Text(
            viewModel.listAllPokemon[index].name,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TagWidget(
                textType: viewModel.listAllPokemon[index].type1 ?? "",
              ),
              TagWidget(
                textType: viewModel.listAllPokemon[index].type2 ?? "",
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
