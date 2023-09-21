import 'package:flutter/material.dart';

class DefaultTweenAnimationBuilder<T> extends StatelessWidget {
  const DefaultTweenAnimationBuilder({
    super.key,
    required this.initial,
    required this.updated,
    required this.builder,
  });
  final T initial;
  final T updated;
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.ease,
      tween: Tween<T>(begin: initial, end: updated),
      duration: const Duration(milliseconds: 200),
      builder: builder,
    );
  }
}
