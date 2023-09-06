import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_state.dart';

import 'package:matma/steps_simulation_pro/items/floor/presentation/floor_gesture_detector.dart';
import 'package:matma/steps_simulation_pro/items/floor/presentation/floor_painter.dart';

class Floor extends StatelessWidget {
  const Floor({super.key, required this.cubit});
  final FloorCubit cubit;

  @override
  Widget build(BuildContext context) {
    final initialState = cubit.state;
    return BlocProvider<FloorCubit>(
      create: (context) => cubit,
      child: BlocBuilder<FloorCubit, FloorState>(
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
                child: TweenAnimationBuilder(
                    curve: Curves.ease,
                    key: state.id,
                    tween: Tween<Offset>(
                        begin: initialState.size, end: state.size),
                    duration: const Duration(milliseconds: 100),
                    builder: (context, offset, widget) {
                      print(initialState.size);
                      print(Size(offset.dx, offset.dy));
                      state.size = Offset(offset.dx, offset.dy);
                      return FloorGestureDetector(
                        child: CustomPaint(
                          size: Size(offset.dx, offset.dy),
                          painter: FloorPainter(state),
                        ),
                      );
                    }),
              );
            },
          );
        },
      ),
    );
  }
}

// class SizeAnimation extends StatelessWidget {
//   const SizeAnimation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FloorCubit, FloorState>(
//       builder: (context, state) {
//         return TweenAnimationBuilder(
//           key: state.id,
//           tween:
//               Tween<Offset>(begin: initialState.position, end: state.position),
//           duration: const Duration(milliseconds: 200),
//           builder: (context, offset, widget) {
//             return Positioned(
//               left: offset.dx,
//               top: offset.dy,
//               child: FloorGestureDetector(
//                 child: CustomPaint(
//                   size: Size(state.size.dx, state.size.dy),
//                   painter: FloorPainter(state),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
