import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../moldels/details_page_model.dart';
import '../../viewmodels/pokemon_detail_viewmodel.dart';
import 'components/text_formatter_spec.dart';

class DetailsPokemon extends StatefulWidget {
  static const routeName = '/details';
  const DetailsPokemon({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
  }) : super(key: key);
  final String id;
  final String image;
  final String name;
  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon>
    with TickerProviderStateMixin {
  TabController? controller;
  /*  var _isInit = true;
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final pokeId = ModalRoute.of(context)?.settings.arguments;
      Provider.of<PokemonDetailViewModel>(context, listen: false)
          .fetchDetails(pokeId.toString())
          .then((_) {});
      Provider.of<PokemonDetailViewModel>(context, listen: false)
          .fetchPokemonDetail(pokeId.toString())
          .then((_) {});
    }
    _isInit = false;
  }*/
  @override
  void initState() {
    final viewModel = context.read<PokemonDetailViewModel>();
    viewModel.fetchPokemonDetail(widget.id);
    viewModel.fetchDetails(widget.id);
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonDetailViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              toBeginningOfSentenceCase(widget.name)!,
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "N° ${widget.id}",
              style: GoogleFonts.poppins(color: Colors.grey[600]),
            )
          ],
        ),
      ),
      body: Wrap(
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
                        tag: 'imageHero: ${widget.id}',
                        child: Image.network(widget.image),
                      ),
                    ]),
              ),
              Expanded(
                  flex: 1,
                  child: AnimatedBuilder(
                    animation: viewModel.state,
                    builder: (context, child) {
                      return stateManagement(viewModel.state.value);
                    },
                  ))
            ],
          ),
        ],
      ),
    );
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

  _error() {
    final viewModel = context.watch<PokemonDetailViewModel>();
    return ElevatedButton(
        onPressed: () => viewModel.fetchPokemonDetail(widget.id),
        child: const Text("Erro"));
  }

  _success() {
    final viewModel = context.watch<PokemonDetailViewModel>();
    final index = ValueNotifier<int>(0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          height: 100,
          child: PageView(
            onPageChanged: (value) {
              controller!.index = value;
            },
            children: [
              Text(
                toBeginningOfSentenceCase(
                    viewModel.pokemonDetails.flavorTextEntries![9].flavorText ??
                        '')!,
                style: GoogleFonts.poppins(),
              ),
              Text(
                toBeginningOfSentenceCase(viewModel
                        .pokemonDetails.flavorTextEntries![10].flavorText ??
                    '')!,
                style: GoogleFonts.poppins(),
              )
            ],
          ),
        ),
        ValueListenableBuilder(
            valueListenable: index,
            builder: ((context, value, child) {
              return TabPageSelector(
                controller: controller,
              );
            })),
        Card(
          elevation: 10,
          color: const Color(0xFF6390F0),
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
                        .pokemonDetailsStats.abilities?[0].ability!.name)!,
                    description: 'Abilities',
                  ),
                ],
              )
            ],
          ),
        )
      ],
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

  String convertValue(value) {
    double convertedValue = value / 10;
    return convertedValue.toString();
  }
}
