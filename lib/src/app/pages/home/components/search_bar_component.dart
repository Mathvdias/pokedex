import 'package:flutter/cupertino.dart';

import '../../details-page/details_page_pokemon.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: _textController,
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          Navigator.pushNamed(
            context,
            DetailsPokemon.routeName,
            arguments: value,
          );
        }
      },
      placeholder: "Pesquise um pokémon pelo nome ou id",
    );
  }
}
