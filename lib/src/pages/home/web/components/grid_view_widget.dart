import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.listAllPokemon.length,
          itemBuilder: (context, index) {
            final poke = viewModel.listAllPokemon[index];
            return FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.9,
              child: Card(
                shadowColor: setCardColor(poke.type1).withValues(alpha: 0.6),
                color: setCardColor(poke.type1),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => context.go('/details/${poke.id}'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: CachedNetworkImageProvider(
                          poke.sprite.toString(),
                          maxHeight: 100,
                          maxWidth: 100,
                        ),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Expanded(
                            child: Center(child: Image.asset('assets/images/pokeLoad.gif')),
                          );
                        },
                      ),
                      const Spacer(),
                      Text(
                        '#${poke.id}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: width <= 1280 ? 20 : 25,
                              color: Colors.black54,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: FittedBox(
                          child: Text(
                            toBeginningOfSentenceCase(poke.name) ?? poke.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontSize: width <= 1390 && width >= 1110 ? 15 : width < 1110 ? 16 : 25,
                              shadows: const [
                                Shadow(offset: Offset(2, 2), blurRadius: 7, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChipComponent(poke: poke.type1),
                              const SizedBox(width: 5),
                              if (poke.type2 != null) ChipComponent(poke: poke.type2!),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: width < 835 ? 2 : width < 1280 ? 3 : 4,
          ),
        ),
        if (viewModel.state.value == ResultState.loading)
          Positioned(
            bottom: height * .1,
            child: Image.asset('assets/images/pokeLoad.gif', scale: 3 / 4),
          ),
      ],
    );
  }
}
