import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/quest/items/line/cubit/line_cubit.dart';

const double lineFontSize = 25.0;

class Line extends StatelessWidget {
  const Line({super.key, required this.cubit});
  final LineCubit cubit;

  @override
  Widget build(BuildContext context) {
    final initialState = cubit.state.copyWith();
    return BlocProvider<LineCubit>(
      create: (context) => cubit,
      child: BlocBuilder<LineCubit, LineState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            halfHeightOffset: false,
            initialState: initialState,
            state: state,
            halfWidthOffset: false,
            bottomPositioning: true,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                    child: SizedBox(
                  width: state.size.value.dx,
                  height: state.size.value.dy,
                  child: Text(state.text,
                      key: state.id,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontSize: lineFontSize,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
