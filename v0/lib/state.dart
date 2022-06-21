import 'dart:collection';
import 'dart:math' as math;

abstract class StateManagable {
  void refreshState();
}

enum RocketAction { left, forward, right }

class StateManager {
  late StateManagable _state;

  final Map<RocketAction, bool> _buttonsDown = <RocketAction, bool>{
    RocketAction.left: false,
    RocketAction.forward: false,
    RocketAction.right: false,
  };

  late double _rocketX = 0.0;
  late double _rocketY = 0.0;
  late double _angleDegree = -90.0;

  StateManager({required StateManagable state}) {
    _state = state;
  }

  Map<RocketAction, bool> get buttonsDown {
    return _buttonsDown;
  }

  void setButtonDown(RocketAction action, bool down) {
    _buttonsDown[action] = down;
  }

  bool get rocketMoving {
    return _buttonsDown[RocketAction.left] == true ||
        _buttonsDown[RocketAction.forward] == true ||
        _buttonsDown[RocketAction.right] == true ||
        false;
  }

  double get rocketX {
    return _rocketX;
  }

  double get rocketY {
    return _rocketY;
  }

  double get angleRadian {
    return _angleDegree * (math.pi / 180);
  }

  void tick(double deltaT) {
    if (_buttonsDown[RocketAction.left] == true) {
      _angleDegree--;
    }

    if (_buttonsDown[RocketAction.right] == true) {
      _angleDegree++;
    }

    if (_buttonsDown[RocketAction.forward] == true) {
      double x = math.cos(this.angleRadian);
      double y = math.sin(this.angleRadian);

      _rocketX += x;
      _rocketY += y;
    }

    _state.refreshState();
  }
}

// vim: ts=2 sw=2
