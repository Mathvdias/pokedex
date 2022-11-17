import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/service/providers/impl/dio_client_provider.dart';

import '../../service/repository/impl/pokemon_details_repository.dart';
import '../../viewmodels/pokemon_detail_viewmodel.dart';
import 'components/text_formatter_spec.dart';

class DetailsPokemon extends StatefulWidget {
  static const routeName = '/detailScreen';
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

class _DetailsPokemonState extends State<DetailsPokemon> {
  final viewModel = PokemonDetailViewModel(
      PokemonDetailsRepository(DioClient.withAuthBasic()));
  //var _isInit = true;
/*  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final pokeId = ModalRoute.of(context).settings.arguments as String;
      Provider.of<PokeProvider>(context, listen: false)
          .getPokeData(pokeId)
          .then((_) {});
    }
    _isInit = false;
  }*/
  @override
  void initState() {
    viewModel.fetchPokemonDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
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
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'imageHero: ${widget.id}',
                      child: Image.network(widget.image),
                    ),
                  ]),
              Expanded(
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

  stateManagement(ResultDetail state) {
    switch (state) {
      case ResultDetail.start:
        return _start();
      case ResultDetail.loading:
        return _loading();
      case ResultDetail.success:
        return _success();
      case ResultDetail.error:
        return _error();

      default:
        return _start();
    }
  }

  _error() {
    return ElevatedButton(
        onPressed: () => viewModel.fetchPokemonDetail(widget.id),
        child: Text("Erro"));
  }

  _success() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(""),
        Card(
          elevation: 10,
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  TextFormatterSpecs(
                    text: "${convertValue(viewModel.pokemonDetail.height)} m",
                    description: 'Height',
                  ),
                  TextFormatterSpecs(
                    text: "${convertValue(viewModel.pokemonDetail.weight)} kg",
                    description: 'Weight',
                  ),
                  const TextFormatterSpecs(
                    text: ' ♂ ♀ ',
                    description: 'Gender',
                  )
                ],
              ),
              Column(
                children: [
                  const TextFormatterSpecs(
                    text: "",
                    description: 'Category',
                  ),
                  TextFormatterSpecs(
                    text:
                        '${toBeginningOfSentenceCase(viewModel.pokemonDetail.abilities![0].ability!.name)!}\n${toBeginningOfSentenceCase(viewModel.pokemonDetail.abilities![1].ability!.name)!}',
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
    return Center(child: const CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  String convertValue(value) {
    double convertedValue = value / 10;
    return convertedValue.toString();
  }
}
