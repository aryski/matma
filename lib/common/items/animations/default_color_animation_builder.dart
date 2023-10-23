import 'package:flutter/material.dart';

class DefaultColorAnimationBuilder extends StatelessWidget {
  const DefaultColorAnimationBuilder({
    super.key,
    required this.initial,
    required this.updated,
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
  });
  final Color initial;
  final Color updated;
  final Widget Function(BuildContext context, Color? color, Widget? child)
      builder;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.ease,
      tween: ColorTween(begin: initial, end: updated),
      duration: duration,
      builder: builder,
    );
  }
}
