import 'package:flutter/material.dart';
import 'package:pokedex/src/app/text_theme.dart';
import 'package:provider/provider.dart';

import '../pages/details/details_pokemon_page.dart';
import '../pages/home/pokemons_page.dart';
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
            textTheme: ThemesPokedex.textTheme,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
            useMaterial3: true,
            primarySwatch: Colors.orange,
          ),
          initialRoute: '/',
          routes: {
            '/': (_) {
              return const Banner(
                  location: BannerLocation.topEnd,
                  message: 'Matheus',
                  child: HomePage());
            },
            DetailsPokemon.routeName: (context) => const DetailsPokemon(),
          },
        ));
  }
}
