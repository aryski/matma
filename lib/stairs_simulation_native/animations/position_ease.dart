import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/stairs_simulation_native/bloc/stairs_simulation_bloc.dart';

class PositionEase extends StatelessWidget {
  const PositionEase(
      {super.key,
      required this.child,
      required this.startPos,
      required this.endPos});
  final Widget child;
  final Offset startPos;
  final Offset endPos;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      builder: (BuildContext context, Offset value, Widget? child) {
        return Positioned(
          top: value.dy,
          left: value.dx,
          child: child ?? const SizedBox.shrink(),
        );
      },
      curve: Curves.ease,
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: startPos, end: endPos),
      child: child,
    );
  }
}
