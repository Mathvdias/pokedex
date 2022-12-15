import 'package:flutter/material.dart';

import '../../../states/pokemons_states.dart';

class DetailsPagePokemonError extends StatelessWidget {
  const DetailsPagePokemonError({
    Key? key,
    required this.errorPokemonState,
  }) : super(key: key);

  final ErrorPokemonState errorPokemonState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Icon(
              Icons.search_off_rounded,
              size: 100,
              color: Theme.of(context).errorColor,
            ),
            Text(
              'Ops, Houve uma falha ao mostrar os detalhes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              errorPokemonState.message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Voltar para o início :)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).errorColor,
                    ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
