import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class TweenAnimatedPosition extends StatelessWidget {
  const TweenAnimatedPosition({
    super.key,
    required this.child,
    required this.initialPosition,
    required this.updatedPosition,
    required this.duration,
    required this.halfWidthOffset,
    required this.halfHeightOffset,
  });
  final Widget child;
  final Offset initialPosition;
  final Offset updatedPosition;
  final Duration duration;
  final bool halfWidthOffset;
  final bool halfHeightOffset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTweenAnimationBuilder(
            updated: updatedPosition,
            duration: duration,
            initial: initialPosition,
            builder: (context, position, widget) {
              position += Offset(halfWidthOffset ? constraints.maxWidth / 2 : 0,
                  halfHeightOffset ? constraints.maxHeight / 2 : 0);
              return Stack(children: [
                Positioned(left: position.dx, top: position.dy, child: child),
              ]);
            });
      },
    );
  }
}
