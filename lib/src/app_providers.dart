import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app/services/data/providers/impl/dio_client_provider.dart';
import 'app/services/data/repository/impl/pokemon_details_repository.dart';
import 'app/services/data/repository/impl/pokemon_list_repository.dart';
import 'app/services/data/repository/impl/pokemon_repository.dart';
import 'app/services/data/repository/impl/pokemon_request_details_repository.dart';
import 'app/viewmodels/pokemon_detail_viewmodel.dart';
import 'app/viewmodels/pokemons_viewmodel.dart';
final List<SingleChildWidget> providers = <SingleChildWidget>[
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
    create: (context) => PokemonsViewModel(
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
];
