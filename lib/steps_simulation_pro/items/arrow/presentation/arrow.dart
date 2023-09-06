import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation_pro/items/arrow/presentation/arrow_controls.dart';
import 'package:matma/steps_simulation_pro/items/arrow/presentation/arrow_painter.dart';

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
            key: state.id,
            tween: Tween<Offset>(
                begin: initialState.position, end: state.position),
            duration: const Duration(milliseconds: 200),
            builder: (context, offset, widget) {
              return Positioned(
                left: offset.dx,
                top: offset.dy,
                child: ArrowGestureDetector(
                  child: CustomPaint(
                    size: Size(state.size.dx, state.size.dy),
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
