import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/pokemon_detail_viewmodel.dart';

class PageComponent extends StatelessWidget {
  const PageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonDetailViewModel>();
    final index = ValueNotifier<int>(0);
    return Column(
      children: [
        DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: TabBar(
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
                    ? toBeginningOfSentenceCase(viewModel
                            .pokemonDetails.flavorTextEntries![9].flavorText ??
                        '')!
                    : v == 1
                        ? toBeginningOfSentenceCase(viewModel.pokemonDetails
                                .flavorTextEntries![10].flavorText ??
                            '')!
                        : '',
                style: GoogleFonts.poppins(),
              ),
            );
          },
        ),
      ],
    );
  }
}
