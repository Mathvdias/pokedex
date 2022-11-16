import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_tag.dart';

class TagWidget extends StatelessWidget {
  final String textType;

  const TagWidget({
    Key? key,
    required this.textType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textType.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(2.0),
            child: Material(
              elevation: 2,
              shadowColor: colorTag(textType),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: colorTag(textType),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    textType,
                    style: GoogleFonts.poppins(fontSize: 13),
                  )),
            ),
          );
  }
}
