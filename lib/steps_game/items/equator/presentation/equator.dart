import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/common/game_size.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/equator/presentation/equator_painter.dart';

class Equator extends StatelessWidget {
  const Equator({super.key, required this.cubit, required this.gs});
  final EquatorCubit cubit;
  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    EquatorState initialState = cubit.state.copyWith();

    return BlocProvider<EquatorCubit>(
      create: (context) => cubit,
      child: BlocBuilder<EquatorCubit, EquatorState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            gs: gs,
            child: LayoutBuilder(builder: (context, constrains) {
              return CustomPaint(
                size: Size(
                  constrains.maxWidth,
                  constrains.maxHeight,
                ),
                painter: EquatorPainter(
                    constrains.maxWidth,
                    constrains.maxHeight,
                    state.radius *
                        gs.wUnit *
                        MediaQuery.of(context).size.height *
                        1920 /
                        1080,
                    Theme.of(context).colorScheme.secondaryContainer),
              );
            }),
          );
        },
      ),
    );
  }
}
