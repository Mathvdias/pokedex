import 'package:flutter/material.dart';

class DetailsPagePokemonLoading extends StatelessWidget {
  const DetailsPagePokemonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Image.asset('images/poke.gif'),
      ),
    );
  }
}
