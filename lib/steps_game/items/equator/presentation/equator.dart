import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/game_item/default_game_item_animations.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/equator/presentation/equator_painter.dart';


class Equator extends StatelessWidget {
  const Equator({super.key, required this.cubit});
  final EquatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    EquatorState initialState = cubit.state.copy();

    return BlocProvider<EquatorCubit>(
      create: (context) => cubit,
      child: BlocBuilder<EquatorCubit, EquatorState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return CustomPaint(
                size: Size(
                  constrains.maxWidth,
                  constrains.maxHeight,
                ),
                painter: EquatorPainter(
                    constrains.maxWidth,
                    constrains.maxHeight,
                    state.radius * MediaQuery.of(context).size.width,
                    defaultEquator),
              );
            }),
          );
        },
      ),
    );
  }
}
