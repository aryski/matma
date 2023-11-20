import 'package:flutter/material.dart';

class DefaultTweenAnimationBuilder<T> extends StatelessWidget {
  const DefaultTweenAnimationBuilder({
    super.key,
    required this.initial,
    required this.updated,
    required this.builder,
    required this.duration,
  });
  final T initial;
  final T updated;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Duration duration;
  static const double _fastTransitionTime = 150;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: duration.inMilliseconds < _fastTransitionTime
          ? Curves.linear
          : Curves.ease,
      tween: Tween<T>(begin: initial, end: updated),
      duration: duration,
      builder: builder,
    );
  }
}
