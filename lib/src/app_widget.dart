import 'package:flutter/material.dart';
import 'package:pokedex/src/app/service/providers/impl/dio_client_provider.dart';
import 'package:pokedex/src/app/service/repository/impl/pokemon_repository.dart';
import 'package:pokedex/src/app/viewmodels/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

import 'app/pages/details-page/details_page_pokemon.dart';
import 'app/pages/home/home_page.dart';

import 'app/service/repository/impl/pokemon_details_repository.dart';
import 'app/service/repository/impl/pokemon_list_repository.dart';
import 'app/service/repository/impl/pokemon_request_details_repository.dart';
import 'app/viewmodels/pokemon_detail_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //  Provider(create: (_) => DioClient.withAuthBasic()),
          Provider(
            create: (_) => PokemonDetailsRepository(
              DioClient.withAuthBasic(),
            ),
          ),
          Provider(
            create: (_) => PokemonRepository(
              DioClient.withAuthBasic(),
            ),
          ),
          Provider(
            create: (_) => PokemonListRepository(
              DioClient.withAuthBasic(),
            ),
          ),
          Provider(
            create: (context) => PokemonDetailsStatsRepository(
              DioClient.withAuthBasic(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => PokemonViewModel(
              context.read(),
              context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => PokemonDetailViewModel(
              context.read(),
              context.read(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PokeDex',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
            useMaterial3: true,
            primarySwatch: Colors.blueGrey,
          ),
          home: const Banner(
              location: BannerLocation.topEnd,
              message: 'Matheus',
              child: MyHomePage(title: 'PokeDex')),
          routes: {
            DetailsPokemon.routeName: (context) => const DetailsPokemon(),
          },
        ));
  }
}
