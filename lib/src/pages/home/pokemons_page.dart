import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/pages/home/mobile/components/search_bar_component.dart';
import 'package:provider/provider.dart';

import '../../common/chip_component.dart';
import '../../common/colors/map_card_color.dart';
import '../../viewmodels/pokemons_viewmodel.dart';

import '../details/details_pokemon_page.dart';
import 'mobile/home_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    super.build(context);
    final viewModel = context.watch<PokemonsViewModel>();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return HomeIsMobile(
              scaffoldKey: scaffoldKey,
              viewModel: viewModel,
              scrollController: scrollController);
        } else {
          return Scaffold(
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
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 23),
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
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            GridView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: viewModel.listAllPokemon.length,
                              itemBuilder: ((context, index) {
                                final poke = viewModel.listAllPokemon[index];
                                return FractionallySizedBox(
                                  widthFactor: 0.9,
                                  heightFactor: 0.9,
                                  child: Card(
                                    shadowColor: setCardColor(poke.type1)
                                        .withOpacity(0.6),
                                    color: setCardColor(poke.type1),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        DetailsPokemon.routeName,
                                        arguments: (poke.id).toString(),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: CachedNetworkImageProvider(
                                              poke.sprite.toString(),
                                              maxHeight: 100,
                                              maxWidth: 100,
                                            ),
                                            loadingBuilder:
                                                ((context, child, progress) {
                                              if (progress == null) {
                                                return child;
                                              }
                                              return Expanded(
                                                child: Center(
                                                  child: Image.asset(
                                                      'assets/images/pokeLoad.gif'),
                                                ),
                                              );
                                            }),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '#${poke.id.toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                  fontSize: 32,
                                                  color: Colors.black54,
                                                ),
                                          ),
                                          // const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: FittedBox(
                                              child: Text(
                                                '${toBeginningOfSentenceCase(poke.name)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  shadows: <Shadow>[
                                                    const Shadow(
                                                      offset: Offset(2, 2),
                                                      blurRadius: 7,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(
                                            flex: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ChipComponent(poke: poke.type1),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (poke.type2 != null)
                                                ChipComponent(
                                                    poke: poke.type2!),
                                            ],
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 5,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 4,
                              ),
                            ),
                            if (viewModel.state.value == ResultState.loading)
                              Positioned(
                                bottom: height * .1,
                                child: Image.asset(
                                  'assets/images/pokeLoad.gif',
                                  scale: 3 / 4,
                                ),
                              ),
                          ],
                        );
                      }))),
            ),
          );
        }
      },
    );
  }
}
