import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class TweenAnimatedPosition extends StatelessWidget {
  const TweenAnimatedPosition(
      {super.key,
      required this.child,
      required this.initialPosition,
      required this.updatedPosition});
  final Widget child;
  final Offset initialPosition;
  final Offset updatedPosition;

  @override
  Widget build(BuildContext context) {
    return DefaultTweenAnimationBuilder(
        initial: initialPosition,
        updated: updatedPosition,
        builder: (context, position, widget) {
          return Positioned(left: position.dx, top: position.dy, child: child);
        });
  }
}
