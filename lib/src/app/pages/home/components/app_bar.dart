import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarComponent extends StatelessWidget with PreferredSizeWidget {
  const AppBarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Pokedex",
            style:
                GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: height >= 1080 ? height / 3 : 16),
            child: const CupertinoSearchTextField(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(168.0);
}
