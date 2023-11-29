import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/prompts/items/line/cubit/line_cubit.dart';

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
            initialState: initialState,
            state: state,
            child: Center(
              child: SizedBox(
                width: state.size.value.dx * MediaQuery.of(context).size.width,
                height:
                    state.size.value.dy * MediaQuery.of(context).size.height,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(state.text,
                      key: state.id,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
