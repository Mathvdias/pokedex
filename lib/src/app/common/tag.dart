import 'package:flutter/material.dart';

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
        : Material(
            elevation: 2,
            shadowColor: colorTag(textType),
            borderRadius: BorderRadius.circular(15),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: colorTag(textType),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(textType)),
          );
  }
}
