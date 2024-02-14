import 'package:flutter/material.dart';
import 'package:matma/common/square_button/hoverable_square/hoverable_square.dart';
import 'package:matma/common/square_button/hoverable_square/rounded_square.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    this.locked = false,
    required this.minature,
    this.onTap,
    required this.text,
    required this.sideWidth,
  })  : radius = sideWidth / 10,
        stroke = 6 / 200 * sideWidth;
  final double sideWidth;
  final double stroke;
  final double radius;
  final bool locked;
  final Widget minature;
  final String text;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return locked
        ? Padding(
            padding: EdgeInsets.all(stroke),
            child: RoundedSquare(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.7),
              radius: radius - stroke,
              sideWidth: sideWidth - 2 * stroke,
              child: LevelSquareDetails(
                  locked: locked, minature: minature, text: text),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: HoverableSquare(
              color: Theme.of(context).colorScheme.secondaryContainer,
              hoverOutlineColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              sideWidth: sideWidth,
              stroke: stroke,
              radius: radius,
              child: LevelSquareDetails(
                  locked: locked, minature: minature, text: text),
            ),
          );
  }
}

class LevelSquareDetails extends StatelessWidget {
  const LevelSquareDetails({
    super.key,
    required this.locked,
    required this.minature,
    required this.text,
  });

  final bool locked;
  final Widget minature;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: FittedBox(
              fit: BoxFit.fill,
              child: locked
                  ? Icon(Icons.lock,
                      color: Theme.of(context).colorScheme.onSecondaryContainer)
                  : minature,
            ),
          ),
          Flexible(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
