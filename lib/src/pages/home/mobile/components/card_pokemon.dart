import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/text_theme.dart';

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
    final typeColor = setCardColor(poke.type1);

    return GestureDetector(
      onTap: () => context.go('/details/${poke.id}'),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: typeColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
        ),
        child: Row(
          children: [
            // Sprite
            SizedBox(
              width: 100,
              child: CachedNetworkImage(
                imageUrl: poke.sprite.toString(),
                height: 90,
                width: 90,
                placeholder: (_, __) => Center(
                  child: Image.asset('assets/images/pokeLoad.gif', height: 50),
                ),
                errorWidget: (_, __, ___) => const Icon(Icons.catching_pokemon, size: 50, color: Colors.white54),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#${poke.id.toString().padLeft(3, '0')}',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 9,
                        color: PokedexColors.yellow,
                        shadows: const [Shadow(color: Colors.black45, offset: Offset(1, 1))],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      (toBeginningOfSentenceCase(poke.name) ?? poke.name).toUpperCase(),
                      style: GoogleFonts.pressStart2p(
                        fontSize: 9,
                        color: Colors.white,
                        shadows: const [Shadow(color: Colors.black45, offset: Offset(1, 1))],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ChipComponent(poke: poke.type1),
                        if (poke.type2 != null) ...[
                          const SizedBox(width: 6),
                          ChipComponent(poke: poke.type2!),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
