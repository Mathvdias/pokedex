import 'package:flutter/material.dart';
import 'src/app/app_widget.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const PokedexApp());
}
