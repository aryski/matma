import 'package:flutter/material.dart';
import 'package:matma/common/buttons/square_button/square_button.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.next,
    required this.sideWidth,
  });
  static const text = "Następny";
  final double sideWidth;
  final Widget? next;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SquareButton(
        sideWidth: sideWidth,
        onTap: () {
          if (next != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => next!));
          }
        },
        minature: const Icon(Icons.keyboard_double_arrow_right_rounded),
        text: text,
      ),
    );
  }
}
