import 'package:flutter/material.dart';
import 'package:matma/common/square_button/square_button.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key, required this.sideWidth});
  final double sideWidth;

  static const text = "Menu";

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SquareButton(
        sideWidth: sideWidth,
        onTap: () {
          Navigator.pop(context);
        },
        minature: const Icon(Icons.home_filled),
        text: text,
      ),
    );
  }
}
