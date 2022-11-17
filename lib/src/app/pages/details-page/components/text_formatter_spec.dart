import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormatterSpecs extends StatelessWidget {
  const TextFormatterSpecs({
    Key? key,
    required this.description,
    required this.text,
  }) : super(key: key);
  final String description;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
