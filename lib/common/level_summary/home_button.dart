import 'package:flutter/material.dart';
import 'package:matma/common/square_button/square_button.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  static const text = "Menu";

  @override
  Widget build(BuildContext context) {
    return SquareButton(
      width: 200,
      height: 200,
      unlocked: true,
      onTap: () {
        Navigator.pop(context);
      },
      minature: const Icon(Icons.home_filled),
      text: text,
      textColor: Colors.black87,
    );
  }
}
