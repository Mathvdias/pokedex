import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/app/text_theme.dart';

import '../../../viewmodels/pokemons_viewmodel.dart';
import '../mobile/components/search_bar_component.dart';
import 'components/grid_view_widget.dart';

class HomeIsWeb extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PokemonsViewModel viewModel;
  final ScrollController scrollController;
  final double height;
  final double width;

  const HomeIsWeb({
    super.key,
    required this.scaffoldKey,
    required this.viewModel,
    required this.scrollController,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final contentWidth = width.clamp(320.0, 1400.0);
    final sidePad = (width - contentWidth) / 2;

    return Scaffold(
      backgroundColor: PokedexColors.cream,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PokedexColors.red,
        toolbarHeight: 64,
        title: Text(
          'POKÉDEX',
          style: GoogleFonts.pressStart2p(
            fontSize: 18,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                sidePad.clamp(16.0, double.infinity), 0,
                sidePad.clamp(16.0, double.infinity), 10),
            child: const SearchBarComponent(),
          ),
        ),
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 3)),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: sidePad.clamp(16.0, double.infinity),
          vertical: 12,
        ),
        child: AnimatedBuilder(
          animation: viewModel.state,
          builder: (context, child) {
            return GridViewWidget(
              viewModel: viewModel,
              height: height,
              width: contentWidth,
            );
          },
        ),
      ),
    );
  }
}
