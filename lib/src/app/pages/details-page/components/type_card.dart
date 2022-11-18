import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/src/app/common/color_tag.dart';

import '../../../common/set_icon.dart';

class TypeCard extends StatelessWidget {
  final String type;
  const TypeCard(this.type, {super.key});
  @override
  Widget build(BuildContext context) {
    String typeIcon = setTypeIcon(type);
    String? typeText = toBeginningOfSentenceCase(type);
    return Material(
      elevation: 2,
      shadowColor: colorTag(type),
      borderRadius: BorderRadius.circular(3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: colorTag(type),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              typeIcon,
              style: const TextStyle(
                fontFamily: 'PokeGoTypes',
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              typeText!,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(1.5, 2),
                    blurRadius: 3.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
