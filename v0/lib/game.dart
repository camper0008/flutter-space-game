import 'package:flutter/material.dart';
import 'package:app_v0/state.dart';
import 'package:app_v0/action_bar.dart';
import 'dart:async';
import 'dart:math' as math;

import 'levels/levelHandler.dart';

class GamePage extends StatefulWidget {
  final int level;

  GamePage({required this.level});
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
    var before = DateTime.now();
    _tickTimer = Timer.periodic(const Duration(milliseconds: 16), (_timer) {
      var now = DateTime.now();
      var deltaT = before.difference(now);
      before = now;
      _stateManager.tick(deltaT.inMicroseconds / 1000000);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () {
    //   Stack(children: [loadLevel(widget.level, context)]);
    // });
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(_stateManager.rocketX, _stateManager.rocketY),
            child: Transform.rotate(
              angle: _stateManager.angleRadian + math.pi * 0.5,
              child: Image.asset(
                  _stateManager.rocketMoving
                      ? 'assets/sus-25-flame.png'
                      : 'assets/sus-25.png',
                  width: 100),
            ),
          ),
          loadLevel(widget.level, context)
        ],
      ),
      bottomNavigationBar: ActionBar(
          setButtonDown: _stateManager.setButtonDown,
          buttonsDown: _stateManager.buttonsDown),
    );
  }
}

// vim: ts=2 sw=2
