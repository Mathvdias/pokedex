import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../states/pokemons_states.dart';

class DetailsPagePokemonError extends StatelessWidget {
  const DetailsPagePokemonError({super.key, required this.errorPokemonState});

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
              color: Theme.of(context).colorScheme.error,
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
              onPressed: () => context.go('/'),
              child: Text(
                'Voltar para o início :)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
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
