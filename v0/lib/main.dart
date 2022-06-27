import 'package:app_v0/start.dart';
import 'package:flutter/material.dart';

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
      home: StartPage(),
    );
  }
}

// vim: ts=2 sw=2
