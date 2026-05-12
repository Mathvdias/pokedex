import 'package:flutter/material.dart';
import 'package:pokedex/src/app/text_theme.dart';
import 'package:provider/provider.dart';

import 'app_providers.dart';
import 'router.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'PokeDex',
        routerConfig: appRouter,
        theme: ThemeData(
          textTheme: ThemesPokedex.textTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
