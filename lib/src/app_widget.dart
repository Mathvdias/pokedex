import 'package:flutter/material.dart';

import 'app/pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const Banner(
          location: BannerLocation.topEnd,
          message: 'Matheus Dias',
          child: MyHomePage(title: 'PokeDex')),
    );
  }
}