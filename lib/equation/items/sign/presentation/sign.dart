import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/game_size.dart';

class Sign extends StatelessWidget {
  const Sign({super.key, required this.cubit, required this.gs});
  final SignCubit cubit;
  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    SignState initialState = cubit.state.copyWith();

    return BlocProvider<SignCubit>(
      create: (context) => cubit,
      child: BlocBuilder<SignCubit, SignState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            gs: gs,
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return SizedBox(
                width: constrains.maxWidth,
                height: constrains.maxHeight,
                child: Container(
                  color: Colors.grey.withOpacity(0.0),
                  child: Center(
                    child: Text(
                      state.value == Signs.addition ? "+" : "-",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: state.size.value.dx *
                              gs.wUnit *
                              MediaQuery.of(context).size.width),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
