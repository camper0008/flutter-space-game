import 'package:flutter/material.dart';
import 'package:app_v0/state.dart';
import 'package:app_v0/action_bar.dart';
import 'dart:async';
import 'dart:math' as math;

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> implements StateManagable {
  late StateManager _stateManager;
  late Timer _tickTimer;

  @override
  void refreshState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _stateManager = StateManager(state: this);
    _tickTimer = Timer.periodic(const Duration(milliseconds: 16), (_timer) {
      _stateManager.tick();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Transform.translate(
          offset: Offset(_stateManager.rocketX, _stateManager.rocketY),
          child: Transform.rotate(
            angle: _stateManager.angleRadian + math.pi * 0.25,
            child: Text("🚀", style: TextStyle(fontSize: 50.0)),
          ),
        ),
        bottomNavigationBar: ActionBar(
            setButtonDown: _stateManager.setButtonDown,
            buttonsDown: _stateManager.buttonsDown),
      );
}

// vim: ts=2 sw=2
