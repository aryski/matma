import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/square_button/hoverable_square/hoverable_square_cubit.dart';
import 'package:matma/common/square_button/hoverable_square/rounded_square.dart';

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
              Padding(
                padding: EdgeInsets.all(stroke),
                child: RoundedSquare(
                    color: color,
                    radius: radius - stroke,
                    sideWidth: sideWidth - 2 * stroke,
                    child: child),
              )
            ]),
          );
        },
      ),
    );
  }
}
