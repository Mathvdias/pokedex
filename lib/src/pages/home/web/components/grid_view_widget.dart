import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/text_theme.dart';

import '../../../../common/chip_component.dart';
import '../../../../common/colors/map_card_color.dart';
import '../../../../viewmodels/pokemons_viewmodel.dart';

class GridViewWidget extends StatelessWidget {
  final PokemonsViewModel viewModel;
  final double height;
  final double width;

  const GridViewWidget({
    super.key,
    required this.viewModel,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = viewModel.state.value == ResultState.loading;
    final crossAxisCount = width < 600 ? 2 : width < 900 ? 3 : width < 1200 ? 4 : 5;

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.listAllPokemon.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4.2,
          ),
          itemBuilder: (context, index) {
            final poke = viewModel.listAllPokemon[index];
            final typeColor = setCardColor(poke.type1);

            return GestureDetector(
              onTap: () => context.go('/details/${poke.id}'),
              child: Container(
                decoration: BoxDecoration(
                  color: typeColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#${poke.id.toString().padLeft(3, '0')}',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 8,
                        color: PokedexColors.yellow,
                        shadows: const [Shadow(color: Colors.black45, offset: Offset(1, 1))],
                      ),
                    ),
                    const SizedBox(height: 4),
                    CachedNetworkImage(
                      imageUrl: poke.sprite.toString(),
                      height: 90,
                      width: 90,
                      placeholder: (_, __) => SizedBox(
                        height: 90,
                        child: Center(child: Image.asset('assets/images/pokeLoad.gif', height: 50)),
                      ),
                      errorWidget: (_, __, ___) => const Icon(Icons.catching_pokemon, size: 60, color: Colors.white54),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: FittedBox(
                        child: Text(
                          (toBeginningOfSentenceCase(poke.name) ?? poke.name).toUpperCase(),
                          style: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            color: Colors.white,
                            shadows: const [Shadow(color: Colors.black45, offset: Offset(1, 1))],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChipComponent(poke: poke.type1),
                        if (poke.type2 != null) ...[
                          const SizedBox(width: 4),
                          ChipComponent(poke: poke.type2!),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            );
          },
        ),
        if (isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(child: Image.asset('assets/images/pokeLoad.gif', height: 70)),
          ),
      ],
    );
  }
}
