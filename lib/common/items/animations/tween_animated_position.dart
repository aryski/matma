import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class TweenAnimatedPosition extends StatelessWidget {
  const TweenAnimatedPosition({
    super.key,
    required this.child,
    required this.initialPosition,
    required this.updatedPosition,
    required this.duration,
    required this.noResize,
    required this.halfWidthOffset,
    required this.halfHeightOffset,
  });
  final Widget child;
  final Offset initialPosition;
  final Offset updatedPosition;
  final Duration duration;
  final bool noResize;
  final bool halfWidthOffset;
  final bool halfHeightOffset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTweenAnimationBuilder(
            duration: duration,
            initial: initialPosition,
            updated: updatedPosition,
            builder: (context, position, widget) {
              return Stack(children: [
                Positioned(
                    left: noResize
                        ? halfWidthOffset
                            ? position.dx + constraints.maxWidth / 2
                            : position.dx
                        : halfWidthOffset
                            ? (position.dx *
                                    constraints.maxHeight *
                                    1920 /
                                    1080) +
                                constraints.maxWidth / 2
                            : (position.dx *
                                constraints.maxHeight *
                                1920 /
                                1080),
                    top: halfHeightOffset
                        ? noResize
                            ? position.dy
                            : (position.dy * constraints.maxHeight) +
                                constraints.maxHeight / 2
                        : noResize
                            ? position.dy
                            : (position.dy * constraints.maxHeight),
                    child: child),
              ]);
            });
      },
    );
  }
}
