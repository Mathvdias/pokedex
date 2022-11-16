import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/text_formatter_spec.dart';

class DetailsPokemon extends StatefulWidget {
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Version"),
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
                                text: '0.6m',
                                description: 'Height',
                              ),
                              TextFormatterSpecs(
                                text: '0.6m',
                                description: 'Weight',
                              ),
                              TextFormatterSpecs(
                                text: ' ♂ ♀ ',
                                description: 'Gender',
                              )
                            ],
                          ),
                          Column(
                            children: [
                              TextFormatterSpecs(
                                text: '0.6m',
                                description: 'Category',
                              ),
                              TextFormatterSpecs(
                                text: '0.6m',
                                description: 'Abilities',
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
