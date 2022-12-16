import 'package:flutter/material.dart';

import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';

class TextFormatterSpecs extends StatelessWidget {
  const TextFormatterSpecs({
    Key? key,
    required this.description,
    required this.text,
    required this.model,
  }) : super(key: key);
  final String description;
  final String text;
  final LoadedPokemonState model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(description,
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      color:
                          setTypeColor(model.pokemonDetailsStats.type1 ?? ''),
                    )),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
