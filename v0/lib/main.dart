import 'package:flutter/material.dart';
import 'package:app_v0/game.dart';

void main() {
  runApp(const TrashApp());
}

class TrashApp extends StatefulWidget {
  const TrashApp({Key? key}) : super(key: key);

  @override
  State createState() => _TrashAppState();
}

class _TrashAppState extends State<TrashApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GamePage(),
    );
  }
}

// vim: ts=2 sw=2
