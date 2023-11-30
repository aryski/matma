import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class TweenAnimatedPosition extends StatelessWidget {
  const TweenAnimatedPosition({
    super.key,
    required this.child,
    required this.initialPosition,
    required this.updatedPosition,
    required this.duration,
    required this.keepRatio,
  });
  final Widget child;
  final Offset initialPosition;
  final Offset updatedPosition;
  final Duration duration;
  final bool keepRatio;

  @override
  Widget build(BuildContext context) {
    return DefaultTweenAnimationBuilder(
        duration: duration,
        initial: initialPosition,
        updated: updatedPosition,
        builder: (context, position, widget) {
          return Positioned(
              left: keepRatio
                  ? position.dx *
                      MediaQuery.of(context).size.height *
                      1920 /
                      1080
                  : position.dx * MediaQuery.of(context).size.width,
              top: position.dy * MediaQuery.of(context).size.height,
              child: child);
        });
  }
}
