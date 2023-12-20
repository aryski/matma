import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class TweenAnimatedSize extends StatelessWidget {
  const TweenAnimatedSize({
    super.key,
    required this.child,
    required this.initialSize,
    required this.updatedSize,
    required this.duration,
    required this.maxWidth,
    required this.maxHeight,
  });
  final Widget child;
  final Offset initialSize;
  final Offset updatedSize;
  final Duration duration;
  final double maxWidth;
  final double maxHeight;
  @override
  Widget build(BuildContext context) {
    return DefaultTweenAnimationBuilder(
        duration: duration,
        initial: initialSize,
        updated: updatedSize,
        builder: (context, size, widget) {
          var width = size.dx;
          var height = size.dy;
          return ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: width < 0 ? 0 : width,
                  maxWidth: width < 0 ? 0 : width,
                  minHeight: height < 0 ? 0 : height,
                  maxHeight: height < 0 ? 0 : height),
              child: child);
        });
  }
}
