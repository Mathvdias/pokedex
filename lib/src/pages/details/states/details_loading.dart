import 'package:flutter/material.dart';

class DetailsPagePokemonLoading extends StatelessWidget {
  const DetailsPagePokemonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Image.asset('assets/images/pokeLoad.gif'),
        ),
      ),
    );
  }
}
