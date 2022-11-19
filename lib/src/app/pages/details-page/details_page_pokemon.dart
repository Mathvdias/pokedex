import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/pokemon_detail_viewmodel.dart';
import 'components/details_success_mobile_component.dart';
import 'components/details_success_web_component.dart';

class DetailsPokemon extends StatefulWidget {
  const DetailsPokemon({
    Key? key,
  }) : super(key: key);

  static const routeName = '/details';

  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon>
    with TickerProviderStateMixin {
  TabController? controller;

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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
    final pokeId = ModalRoute.of(context)?.settings.arguments as String;
    final viewModel = context.watch<PokemonDetailViewModel>();
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset('assets/images/pokeLoad.gif'),
          const SizedBox(
            height: 100,
          ),
          Text(
            'Lamentamos, mas não foi possivel buscar o pokémon!',
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () => viewModel.fetchPokemonDetail(pokeId),
              child: Text(
                "Recarregar",
                style: GoogleFonts.poppins(),
              )),
          const SizedBox(
            height: 25,
          ),
          OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Voltar',
                style: GoogleFonts.poppins(),
              ))
        ],
      ),
    );
  }

  _success() {
    final viewModel = context.watch<PokemonDetailViewModel>();

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        return Scaffold(
          appBar: AppBar(
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
          body: Material(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 64),
                child: isMobile
                    ? const DetailsSuccessMobile()
                    : const DetailSuccessWeb()),
          ),
        );
      },
    );
  }

  _loading() {
    return Material(
      child: Center(
        child: Lottie.asset('assets/images/poke_loading.json',
            frameRate: FrameRate(120), height: 50, width: 50),
      ),
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
        return stateManagement(viewModel.stateDetail.value);
      },
    );
  }
}
