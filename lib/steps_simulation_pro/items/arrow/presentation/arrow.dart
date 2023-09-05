import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/stairs_simulation_native/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/stairs_simulation_native/items/arrow/cubit/arrow_state.dart';
import 'package:matma/stairs_simulation_native/items/arrow/presentation/arrow_controls.dart';
import 'package:matma/stairs_simulation_native/items/arrow/presentation/arrow_painter.dart';

class Arrow extends StatelessWidget {
  const Arrow({super.key, required this.cubit});
  final ArrowCubit cubit;

  @override
  Widget build(BuildContext context) {
    final initialState = cubit.state;
    return BlocProvider<ArrowCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ArrowCubit, ArrowState>(
        builder: (context, state) {
          return TweenAnimationBuilder(
            tween: Tween<Offset>(
                begin: initialState.position, end: state.position),
            duration: const Duration(milliseconds: 200),
            builder: (context, offset, widget) {
              return Positioned(
                left: offset.dy,
                top: offset.dx,
                child: ArrowGestureDetector(
                  child: CustomPaint(
                    size: Size(state.size.width, state.size.height),
                    painter: ArrowPainter(state),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
