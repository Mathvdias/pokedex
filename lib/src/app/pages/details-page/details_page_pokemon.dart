import 'package:flutter/material.dart';

class DetailsPokemon extends StatefulWidget {
  const DetailsPokemon({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;
  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: 'imageHero',
              child: Image.network(widget.image),
            ),
          ),
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text("voltar"))
        ],
      ),
    );
  }
}
