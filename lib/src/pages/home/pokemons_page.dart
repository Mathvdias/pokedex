import 'package:flutter/material.dart';

import 'package:pokedex/src/pages/home/web/home_web.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/pokemons_viewmodel.dart';
import 'mobile/home_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    final viewModel = context.read<PokemonsViewModel>();
    viewModel.fetchNextPage();
    scrollController.addListener(() {
      viewModel.infiniteScrolling(scrollController);
    });
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final viewModel = context.watch<PokemonsViewModel>();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return HomeIsMobile(
              scaffoldKey: scaffoldKey,
              viewModel: viewModel,
              scrollController: scrollController);
        } else {
          return HomeIsWeb(
              scaffoldKey: scaffoldKey,
              viewModel: viewModel,
              scrollController: scrollController,
              height: height,
              width: width);
        }
      },
    );
  }
}
