import 'package:flutter/material.dart';
import 'package:matma/common/square_button/square_button.dart';

class LevelButton extends StatelessWidget {
  final Widget level;
  final IconData icon;
  final String text;
  final bool locked;

  const LevelButton(
      {super.key,
      required this.level,
      required this.icon,
      required this.text,
      required this.locked});
  @override
  Widget build(BuildContext context) {
    return SquareButton(
      sideWidth: 160,
      locked: locked,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => level));
      },
      minature: Icon(icon),
      text: text,
    );
  }
}
