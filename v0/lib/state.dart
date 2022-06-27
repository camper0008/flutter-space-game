import 'dart:math' as math;
import 'package:app_v0/vector2d.dart';

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

  late Vector2d position = Vector2d(0, 0);
  late Vector2d positionalVelocity = Vector2d(0, 0);
  late double angle = 0.0;
  late double angularVelocity = 0.0;

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
    return _buttonsDown[RocketAction.left]! ||
        _buttonsDown[RocketAction.forward]! ||
        _buttonsDown[RocketAction.right]!;
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

  // void tick(double deltaT) {
  //   if (_buttonsDown[RocketAction.left] == true) {
  //     _angleDegree--;
  //   }

  //   if (_buttonsDown[RocketAction.right] == true) {
  //     _angleDegree++;
  //   }

  //   if (_buttonsDown[RocketAction.forward] == true) {
  //     double x = math.cos(this.angleRadian);
  //     double y = math.sin(this.angleRadian);

  //     _rocketX += x;
  //     _rocketY += y;
  //   }

  //   _state.refreshState();
  // }

  double thrustAngle() {
    const angle = (5 / 180) * math.pi;
    return _buttonsDown[RocketAction.left]! &&
            !_buttonsDown[RocketAction.right]!
        ? angle
        : _buttonsDown[RocketAction.right]! && !_buttonsDown[RocketAction.left]!
            ? -angle
            : 0;
  }

  double calculateCylinderMomentOfIntertia(
          double height, double radius, double mass) =>
      (1 / 12) * mass * (3 * math.pow(radius, 2) + math.pow(height, 2));

  double calculateThrustTorque(
          double absoluteForce, double radius, double angle) =>
      radius * absoluteForce * math.sin(angle);

  Vector2d calculateThrustForce(double rocketAngle, double engineRadius,
          double absoluteForce, double engineAngle) =>
      Vector2d(math.sin(rocketAngle + math.pi), math.cos(rocketAngle + math.pi))
          .multiplyN(absoluteForce);

  void tick(double deltaT) {
    var thrustTorque = calculateThrustTorque(5000, 5, thrustAngle());
    var resultingTorque = thrustTorque;
    var momentOfInteria = calculateCylinderMomentOfIntertia(10, 5, 500);
    var rotationalAcceleration = (resultingTorque / momentOfInteria) * deltaT;
    angularVelocity += rotationalAcceleration;
    angle += angularVelocity * deltaT;
    var thrustForce = calculateThrustForce(angle, 5, 5000, thrustAngle());
    var resultingForce = rocketMoving ? thrustForce : Vector2d(0, 0);
    var transitionalAcceleration =
        resultingForce.divideN(500).multiplyN(deltaT);
    positionalVelocity += transitionalAcceleration;
    position += positionalVelocity.copy().multiplyN(deltaT);
    _rocketX = position.x;
    _rocketY = position.y;
    _angleDegree = -(angle / math.pi) * 180 - 90;
    _state.refreshState();
  }
}

// vim: ts=2 sw=2
