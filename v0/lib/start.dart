import 'package:app_v0/levels.dart';
import 'package:app_v0/settings.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  goToLevelsPage(page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => goToLevelsPage(LevelsPage()),
            child: const Text("Play"),
          ),
          ElevatedButton(
            onPressed: () => goToLevelsPage(SettingsPage()),
            child: const Text("Settings"),
          )
        ],
      )
    ]));
  }
}
