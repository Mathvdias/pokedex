import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/pokemon_detail_viewmodel.dart';

class PageComponent extends StatelessWidget {
  const PageComponent({
    Key? key,
    required this.percentWidth,
    required this.percentHeight,
  }) : super(key: key);
  final double percentWidth;
  final double percentHeight;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final viewModel = context.watch<PokemonDetailViewModel>();
    final index = ValueNotifier<int>(0);
    return SizedBox(
      width: width / percentWidth,
      height: height * percentHeight,
      child: Column(
        children: [
          DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              onTap: (value) {
                index.value = value;
              },
              tabs: const <Widget>[
                Tab(
                  text: 'Version 1',
                ),
                Tab(
                  text: 'Version 2',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder(
            valueListenable: index,
            builder: (context, v, child) {
              return Center(
                child: Text(
                  v == 0
                      ? toBeginningOfSentenceCase(viewModel.pokemonDetails
                              .flavorTextEntries![9].flavorText ??
                          '')!
                      : v == 1
                          ? toBeginningOfSentenceCase(viewModel.pokemonDetails
                                  .flavorTextEntries![10].flavorText ??
                              '')!
                          : '',
                  style: GoogleFonts.poppins(
                    fontSize: width <= 1080 ? 13 : 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
 
}
