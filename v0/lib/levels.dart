import 'package:app_v0/game.dart';
import 'package:flutter/material.dart';

class LevelsPage extends StatefulWidget {
  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  void goToLevel(int level) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => GamePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => goToLevel(1),
            child: const Text("Level 1"),
          ),
          ElevatedButton(
            onPressed: () => goToLevel(2),
            child: const Text("Level 2"),
          )
        ],
      )
    ]));
  }
}
