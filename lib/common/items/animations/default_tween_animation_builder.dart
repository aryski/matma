import 'package:flutter/material.dart';

class DefaultTweenAnimationBuilder<T> extends StatelessWidget {
  const DefaultTweenAnimationBuilder({
    super.key,
    required this.initial,
    required this.updated,
    required this.builder,
    required this.duration, // = const Duration(milliseconds: 200),
  });
  final T initial;
  final T updated;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: duration.inMilliseconds < 150 ? Curves.linear : Curves.ease,
      tween: Tween<T>(begin: initial, end: updated),
      duration: duration,
      builder: builder,
    );
  }
}
