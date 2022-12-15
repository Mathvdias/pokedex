import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/pages/details-page/details_page_pokemon.dart';

import 'app/pages/home/home_page.dart';
import 'app/services/data/providers/impl/dio_client_provider.dart';
import 'app/services/data/repository/impl/pokemon_details_repository.dart';
import 'app/services/data/repository/impl/pokemon_list_repository.dart';
import 'app/services/data/repository/impl/pokemon_repository.dart';
import 'app/services/data/repository/impl/pokemon_request_details_repository.dart';
import 'app/viewmodels/pokemon_detail_viewmodel.dart';
import 'app/viewmodels/pokemons_viewmodel.dart';
import 'app_providers.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PokeDex',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
            useMaterial3: true,
            primarySwatch: Colors.blueGrey,
          ),
          initialRoute: '/',
          routes: {
            '/': (_) {
              return const Banner(
                  location: BannerLocation.topEnd,
                  message: 'Matheus',
                  child: HomePage(title: 'PokeDex'));
            },
            DetailsPokemon.routeName: (context) => const DetailsPokemon(),
          },
        ));
  }
}
