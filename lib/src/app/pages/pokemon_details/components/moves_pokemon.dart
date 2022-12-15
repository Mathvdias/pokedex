import 'package:flutter/material.dart';

import '../../../common/colors/map_card_color.dart';

import '../../../states/pokemons_states.dart';

class MovesPokemon extends StatelessWidget {
  const MovesPokemon({
    Key? key,
    required this.poke,
  }) : super(key: key);

  final LoadedPokemonState poke;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: poke.pokemonDetailsStats.moves!.length,
        itemBuilder: ((context, index) => Container(
            decoration: BoxDecoration(
              color: setTypeColor(poke.pokemonDetailsStats.type1.toString()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                poke.pokemonDetailsStats.moves![index],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ))),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 6 / 1.5,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 3,
        ),
      ),
    );
  }
}
