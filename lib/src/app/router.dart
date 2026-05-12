import 'package:flutter_lazy_load_web/flutter_lazy_load_web.dart';
import 'package:go_router/go_router.dart';

import '../pages/home/pokemons_page.dart' deferred as home;
import '../pages/details/details_pokemon_page.dart' deferred as details;
import '../pages/splash/splash_page.dart' deferred as splash;

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: lazy(home.loadLibrary, home.HomePage.new),
    ),
    GoRoute(
      path: '/details/:id',
      builder: lazy(details.loadLibrary, details.DetailsPokemon.new),
    ),
    GoRoute(
      path: '/splash',
      builder: lazy(splash.loadLibrary, splash.SplashPage.new),
    ),
  ],
);
