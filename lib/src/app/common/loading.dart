import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../viewmodels/pokemon_viewmodel.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PokemonViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      child: Visibility(
        visible: viewModel.state.value == ResultState.loading ? true : false,
        child: Lottie.asset('assets/images/poke_loading.json',
            frameRate: FrameRate(120), height: 50, width: 50),
      ),
    );
  }
}
