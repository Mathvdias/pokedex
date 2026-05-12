import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    final value = _controller.text.trim();
    if (value.isNotEmpty) context.go('/details/${value.toLowerCase()}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 2))],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.search, size: 18, color: Colors.black54),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _search(),
              style: GoogleFonts.vt323(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Nome ou número...',
                hintStyle: GoogleFonts.vt323(fontSize: 18, color: Colors.black38),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: _search,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
              child: Text('GO', style: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
