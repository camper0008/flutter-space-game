import 'package:flutter/material.dart';
import 'package:app_v0/state.dart';

typedef void _ActionBarButtonChange(RocketAction value, bool pressed);

Widget _actionButton(_ActionItem item, _ActionBarButtonChange setButtonDown,
        Map<RocketAction, bool> buttonsDown) =>
    Expanded(
      child: SizedBox(
        height: 64.0,
        child: Stack(
          children: [
            Center(
              child: Icon(item.icon,
                  color: buttonsDown[item.action] ?? false
                      ? Colors.black
                      : Colors.white),
            ),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                setButtonDown(item.action, true);
              },
              onTapUp: (TapUpDetails details) {
                setButtonDown(item.action, false);
              },
            ),
          ],
        ),
      ),
    );

class _ActionItem {
  IconData icon;
  RocketAction action;

  _ActionItem(this.icon, this.action);
}

class ActionBar extends StatefulWidget {
  final _ActionBarButtonChange setButtonDown;
  final Map<RocketAction, bool> buttonsDown;
  const ActionBar(
      {Key? key, required this.setButtonDown, required this.buttonsDown})
      : super(key: key);

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  late _ActionBarButtonChange _setButtonDown;
  late Map<RocketAction, bool> _buttonsDown;

  final List<_ActionItem> items = [
    _ActionItem(Icons.rotate_left, RocketAction.left),
    _ActionItem(Icons.accessible_forward, RocketAction.forward),
    _ActionItem(Icons.rotate_right, RocketAction.right),
  ];

  @override
  void initState() {
    super.initState();
    _setButtonDown = widget.setButtonDown;
    _buttonsDown = widget.buttonsDown;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: items
              .map((_ActionItem item) =>
                  _actionButton(item, _setButtonDown, _buttonsDown))
              .toList(),
        ),
      ),
    );
  }
}

// vim: ts=2 sw=2
