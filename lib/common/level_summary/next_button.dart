import 'package:flutter/material.dart';
import 'package:matma/common/square_button/square_button.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.next,
  });
  static const text = "Następny";

  final Widget? next;

  @override
  Widget build(BuildContext context) {
    return SquareButton(
      width: 200,
      height: 200,
      unlocked: true,
      onTap: () {
        if (next != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => next!));
        }
      },
      minature: const Icon(Icons.keyboard_double_arrow_right_rounded),
      text: text,
      textColor: Colors.black87,
    );
  }
}
