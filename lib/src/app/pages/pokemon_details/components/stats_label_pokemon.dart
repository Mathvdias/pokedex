import 'package:flutter/material.dart';

import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';

class StatsLabel extends StatelessWidget {
  const StatsLabel({
    Key? key,
    required this.label,
    required this.value,
    required this.model,
  }) : super(key: key);
  final String label;
  final int value;
  final LoadedPokemonState model;
  @override
  Widget build(BuildContext context) {
    convertValue(value) {
      int initValue = value;
      return initValue.toStringAsFixed(0);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: setTypeColor(model.pokemonDetailsStats.type1 ?? ''),
                ),
          ),
          const Spacer(),
          Text(
            convertValue(value),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: setTypeColor(model.pokemonDetailsStats.type1 ?? ''),
            ),
          ),
          Container(
            width: 150,
            height: 10,
            margin: const EdgeInsets.only(left: 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                    setTypeColor(model.pokemonDetailsStats.type1 ?? '')),
                value: value / 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
