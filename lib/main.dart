import 'package:bird_game/Game.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Game(),
      theme: ThemeData(
        fontFamily: 'ShortBaby',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)
      )
    );
  }
}
