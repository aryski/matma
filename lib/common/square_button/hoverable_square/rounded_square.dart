import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/square_button/hoverable_square/hoverable_square_cubit.dart';

class RoundedSquare extends StatelessWidget {
  const RoundedSquare({
    super.key,
    required this.radius,
    required this.sideWidth,
    this.child,
    required this.color,
  });

  final double radius;
  final double sideWidth;
  final Widget? child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.hardEdge,
      child: Container(
          width: sideWidth, height: sideWidth, color: color, child: child),
    );
  }
}
