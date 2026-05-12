import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../common/chip_component.dart';
import '../../../../common/colors/map_card_color.dart';
import '../../../../services/domain/models/pokemom_model.dart';

class CardPokemonComponent extends StatelessWidget {
  const CardPokemonComponent({
    super.key,
    required this.poke,
    required this.index,
  });

  final int index;
  final PokemonModel poke;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: Card(
        shadowColor: setCardColor(poke.type1).withValues(alpha: 0.6),
        color: setCardColor(poke.type1),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go('/details/${poke.id}'),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Image(
                  image: CachedNetworkImageProvider(
                    poke.sprite.toString(),
                    maxHeight: 250,
                    maxWidth: 250,
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(child: Image.asset('assets/images/pokeLoad.gif'));
                  },
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${poke.id}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 32,
                            color: Colors.black54,
                          ),
                    ),
                    Text(
                      toBeginningOfSentenceCase(poke.name) ?? poke.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        shadows: const [
                          Shadow(offset: Offset(2, 2), blurRadius: 7, color: Colors.grey),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ChipComponent(poke: poke.type1),
                        const SizedBox(width: 5),
                        if (poke.type2 != null) ChipComponent(poke: poke.type2!),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
