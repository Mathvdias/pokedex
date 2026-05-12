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
            seedColor: PokedexColors.red,
            brightness: Brightness.light,
            surface: PokedexColors.cream,
          ),
          scaffoldBackgroundColor: PokedexColors.cream,
          appBarTheme: const AppBarTheme(
            backgroundColor: PokedexColors.red,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: Colors.black,
            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
