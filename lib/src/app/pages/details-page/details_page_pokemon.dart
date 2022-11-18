import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/src/app/common/color_tag.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/pokemon_detail_viewmodel.dart';
import 'components/page_component.dart';
import 'components/text_formatter_spec.dart';

class DetailsPokemon extends StatefulWidget {
  static const routeName = '/details';
  const DetailsPokemon({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon>
    with TickerProviderStateMixin {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final pokeId = ModalRoute.of(context)?.settings.arguments as String;
      Provider.of<PokemonDetailViewModel>(context, listen: false)
          .fetchDetails(pokeId)
          .then((_) {});
      Provider.of<PokemonDetailViewModel>(context, listen: false)
          .fetchPokemonDetail(pokeId)
          .then((_) {});
    }
    _isInit = false;
  }

  TabController? controller;
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  stateManagement(ResultDetailStats state) {
    switch (state) {
      case ResultDetailStats.start:
        return _start();
      case ResultDetailStats.loading:
        return _loading();
      case ResultDetailStats.success:
        return _success();
      case ResultDetailStats.error:
        return _error();

      default:
        return _start();
    }
  }

  String convertValue(value) {
    double convertedValue = value / 10;
    return convertedValue.toString();
  }

  _error() {
    final pokeId = ModalRoute.of(context)?.settings.arguments as String;
    final viewModel = context.watch<PokemonDetailViewModel>();
    return ElevatedButton(
        onPressed: () => viewModel.fetchPokemonDetail(pokeId),
        child: const Text("Erro"));
  }

  _success() {
    final viewModel = context.watch<PokemonDetailViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              toBeginningOfSentenceCase(viewModel.pokemonDetails.name)!,
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "N° ${viewModel.pokemonDetails.id}",
              style: GoogleFonts.poppins(color: Colors.grey[600]),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Wrap(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'imageHero: ${viewModel.pokemonDetails.id}',
                          child: FadeInImage.assetNetwork(
                            image: viewModel.pokemonDetailsStats.sprites!.other!
                                .officialArtwork!.frontDefault
                                .toString(),
                            placeholder: 'assets/images/pokeLoad.gif',
                          ),
                        ),
                      ]),
                ),
                Expanded(
                    flex: 1,
                    child: Card(
                      color: colorTag(viewModel
                          .pokemonDetailsStats.types![0].type!.name
                          .toString()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const PageComponent(),
                          Card(
                            elevation: 10,
                            color: Colors.white60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormatterSpecs(
                                      text:
                                          "${convertValue(viewModel.pokemonDetailsStats.height)} m",
                                      description: 'Height',
                                    ),
                                    TextFormatterSpecs(
                                      text:
                                          "${convertValue(viewModel.pokemonDetailsStats.weight)} kg",
                                      description: 'Weight',
                                    ),
                                    const TextFormatterSpecs(
                                      text: ' ♂ ♀ ',
                                      description: 'Gender',
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormatterSpecs(
                                      text: toBeginningOfSentenceCase(
                                          viewModel.pokemonDetails.species)!,
                                      description: 'Category',
                                    ),
                                    TextFormatterSpecs(
                                      text: toBeginningOfSentenceCase(viewModel
                                          .pokemonDetailsStats
                                          .abilities?[0]
                                          .ability!
                                          .name)!,
                                      description: 'Abilities',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: Lottie.asset('assets/images/poke_loading.json',
          frameRate: FrameRate(120), height: 50, width: 50),
    );
  }

  _start() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonDetailViewModel>();
    return AnimatedBuilder(
      animation: viewModel.state,
      builder: (context, child) {
        return stateManagement(viewModel.state.value);
      },
    );
  }
}
