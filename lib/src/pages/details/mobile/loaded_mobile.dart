import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/text_theme.dart';

import '../../../common/chip_component.dart';
import '../../../common/colors/map_card_color.dart';
import '../../../states/pokemons_states.dart';
import '../components/about_pokemon.dart';
import '../components/moves_pokemon.dart';
import '../components/stats_pokemon.dart';

class LoadedIsMobile extends StatelessWidget {
  final TabController tabController;
  final LoadedPokemonState poke;

  const LoadedIsMobile({
    super.key,
    required this.tabController,
    required this.poke,
  });

  String get _animatedGifUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/${poke.pokemonDetailsStats.id}.gif';

  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(_animatedGifUrl, width: 200, height: 200, fit: BoxFit.contain),
              const SizedBox(height: 8),
              Text(
                'Toque para fechar',
                style: GoogleFonts.vt323(fontSize: 18, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = setTypeColor(poke.pokemonDetailsStats.type1 ?? '');
    final name = toBeginningOfSentenceCase(poke.pokemonDetailsStats.name) ?? '';

    return Scaffold(
      backgroundColor: PokedexColors.cream,
      appBar: AppBar(
        backgroundColor: typeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
        ),
        title: Column(
          children: [
            Text(
              name.toUpperCase(),
              style: GoogleFonts.pressStart2p(fontSize: 11, color: Colors.white),
            ),
            Text(
              '#${poke.pokemonDetailsStats.id.toString().padLeft(3, '0')}',
              style: GoogleFonts.vt323(fontSize: 18, color: Colors.white70),
            ),
          ],
        ),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 3)),
      ),
      body: Column(
        children: [
          // Hero: animated GIF
          Container(
            color: typeColor.withValues(alpha: 0.15),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _showFullImage(context),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Static sprite (background, larger)
                      CachedNetworkImage(
                        imageUrl: poke.pokemonDetailsStats.sprite.toString(),
                        height: 120,
                        width: 120,
                        color: Colors.black12,
                        colorBlendMode: BlendMode.darken,
                      ),
                      // Animated GIF (foreground, hero)
                      Image.network(
                        _animatedGifUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => CachedNetworkImage(
                          imageUrl: poke.pokemonDetailsStats.sprite.toString(),
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'toque para ampliar',
                  style: GoogleFonts.vt323(fontSize: 14, color: Colors.black38),
                ),
                const SizedBox(height: 8),
                // Type chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (poke.pokemonDetailsStats.type1 != null)
                      ChipComponent(poke: poke.pokemonDetailsStats.type1!),
                    if (poke.pokemonDetailsStats.type2 != null) ...[
                      const SizedBox(width: 8),
                      ChipComponent(poke: poke.pokemonDetailsStats.type2!),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    poke.pokemonDetails.description.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.vt323(fontSize: 18, color: Colors.black87, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          // Tab bar
          Container(
            color: Colors.black,
            height: 2,
          ),
          Container(
            color: typeColor.withValues(alpha: 0.1),
            child: TabBar(
              controller: tabController,
              labelColor: typeColor,
              unselectedLabelColor: Colors.black45,
              indicatorColor: typeColor,
              indicatorWeight: 3,
              labelStyle: GoogleFonts.pressStart2p(fontSize: 8),
              unselectedLabelStyle: GoogleFonts.pressStart2p(fontSize: 8),
              tabs: const [
                Tab(text: 'SOBRE'),
                Tab(text: 'STATS'),
                Tab(text: 'GOLPES'),
              ],
            ),
          ),
          Container(color: Colors.black, height: 2),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                AboutPokemon(poke: poke),
                StatsPokemon(poke: poke),
                MovesPokemon(poke: poke),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
