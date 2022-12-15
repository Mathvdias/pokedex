import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/chip_component.dart';
import '../../../common/colors/map_card_color.dart';
import '../../../services/domain/models/pokemom_model.dart';
import '../../pokemon_details/details_pokemon_page.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    Key? key,
    required this.poke,
    required this.index,
  }) : super(key: key);

  final int index;
  final PokemonModel poke;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: Card(
        shadowColor: setCardColor(poke.type1).withOpacity(0.6),
        color: setCardColor(poke.type1),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.pushNamed(
            context,
            DetailsPokemon.routeName,
            arguments: (poke.id).toString(),
          ),
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
                  loadingBuilder: ((context, child, progress) {
                    if (progress == null) {
                      return child;
                    }
                    return Center(
                      child: Image.asset('images/poke.gif'),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${poke.id.toString()}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      '${toBeginningOfSentenceCase(poke.name)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    Row(
                      children: [
                        ChipComponent(poke: poke.type1),
                        const SizedBox(
                          width: 5,
                        ),
                        if (poke.type2 != null)
                          ChipComponent(poke: poke.type2!),
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
