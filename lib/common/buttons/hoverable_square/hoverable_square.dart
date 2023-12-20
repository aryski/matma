import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/buttons/hoverable_square/hoverable_square_cubit.dart';

class HoverableSquare extends StatelessWidget {
  const HoverableSquare(
      {super.key,
      this.onTap,
      required this.sideWidth,
      required this.child,
      required this.color,
      required this.hoverOutlineColor,
      required this.stroke,
      required this.radius});

  final double stroke;
  final double radius;
  final double sideWidth;
  final Color color;
  final Color hoverOutlineColor;
  final Widget child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HoverableSquareCubit(),
      child: BlocBuilder<HoverableSquareCubit, bool>(
        builder: (context, hovered) {
          return MouseRegion(
            hitTestBehavior: HitTestBehavior.deferToChild,
            onEnter: (event) {
              context.read<HoverableSquareCubit>().onHover();
            },
            onExit: (event) {
              context.read<HoverableSquareCubit>().onHoverEnd();
            },
            child: Stack(alignment: Alignment.center, children: [
              RoundedSquare(
                  radius: radius,
                  sideWidth: sideWidth,
                  color: (hovered) ? hoverOutlineColor : Colors.transparent),
              SquareWithPadding(
                  padding: stroke,
                  radius: radius - stroke,
                  sideWidth: sideWidth - 2 * stroke,
                  color: color,
                  child: child)
            ]),
          );
        },
      ),
    );
  }
}

class SquareWithPadding extends StatelessWidget {
  const SquareWithPadding(
      {super.key,
      required this.sideWidth,
      required this.color,
      required this.child,
      required this.radius,
      required this.padding});

  final double padding;
  final double radius;
  final double sideWidth;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: RoundedSquare(
          color: color, radius: radius, sideWidth: sideWidth, child: child),
    );
  }
}

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
