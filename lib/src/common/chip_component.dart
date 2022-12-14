import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/common/set_icon.dart';

import 'colors/map_card_color.dart';

class ChipComponent extends StatelessWidget {
  const ChipComponent({
    Key? key,
    required this.poke,
  }) : super(key: key);

  final String poke;

  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: setTypeColor(poke),
        label: Row(
          children: [
            Text(
              setTypeIcon(poke),
              style: const TextStyle(
                fontFamily: 'PokeGoTypes',
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 7,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              toBeginningOfSentenceCase(poke)!,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.white,
                fontSize: 10,
                shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 7,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
