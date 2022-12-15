import 'package:flutter/material.dart';

class DetailsPagePokemonLoading extends StatelessWidget {
  const DetailsPagePokemonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Image.asset('assets/images/pokeLoad.gif'),
      ),
    );
  }
}
