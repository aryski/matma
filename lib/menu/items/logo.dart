import 'package:flutter/material.dart';
import 'package:matma/equation/items/board/presentation/board_design.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 35 / 9,
          child: Stack(alignment: Alignment.center, children: [
            BoardDesign(
              fillColor: Theme.of(context).colorScheme.background,
              frameColor: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                'Matma',
                style: TextStyle(
                    fontSize: 135,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
