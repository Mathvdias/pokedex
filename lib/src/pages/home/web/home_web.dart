import 'package:flutter/material.dart';
import 'package:pokedex/src/pages/home/web/components/grid_view_widget.dart';

import '../../../viewmodels/pokemons_viewmodel.dart';
import '../mobile/components/search_bar_component.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 3,
        shadowColor: Colors.orange,
        elevation: 0,
        toolbarHeight: 60.2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        title: Text(
          "PokeDex",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 23),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(height * .1),
          child: Padding(
            padding: EdgeInsets.fromLTRB(width / 4, 0, width / 4, 10),
            child: const SearchBarComponent(),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          alignment: FractionalOffset.bottomCenter,
          child: AnimatedBuilder(
            animation: viewModel.state,
            builder: ((context, child) {
              return GridViewWidget(
                viewModel: viewModel,
                scrollController: scrollController,
                height: height,
                width: width,
              );
            }),
          ),
        ),
      ),
    );
  }
}
