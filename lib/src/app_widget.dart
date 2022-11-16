import 'package:flutter/material.dart';

import 'app/pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter PokeDex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
        useMaterial3: true,
        primarySwatch: Colors.blueGrey,
      ),
      home: const Banner(
          location: BannerLocation.topEnd,
          message: 'Matheus',
          child: MyHomePage(title: 'PokeDex')),
    );
  }
}
