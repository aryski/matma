import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';

class Sign extends StatelessWidget {
  const Sign({super.key, required this.cubit});
  final SignCubit cubit;

  @override
  Widget build(BuildContext context) {
    SignState initialState = cubit.state.copyWith();

    return BlocProvider<SignCubit>(
      create: (context) => cubit,
      child: BlocBuilder<SignCubit, SignState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            halfWidthOffset: true,
            noResize: true,
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              // print(constrains.maxHeight);
              return SizedBox(
                width: constrains.maxWidth,
                height: constrains.maxHeight,
                child: Container(
                  color: Colors.grey.withOpacity(0.0),
                  child: AnimatedSwitcher(
                    key: state.id,
                    switchInCurve: Curves.ease,
                    switchOutCurve: Curves.ease,
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    duration: const Duration(milliseconds: 200),
                    child: state.opacity.value == 1.0
                        ? Center(
                            child: Container(
                            height: 90.0,
                            // color: Colors.amberAccent.withOpacity(0.4),
                            child: Builder(builder: (context) {
                              // return Text(
                              //   state.value == Signs.addition ? "+" : "−",
                              //   style: TextStyle(
                              //       color: Theme.of(context)
                              //           .colorScheme
                              //           .onSecondaryContainer,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 75),
                              // );
                              return AspectRatio(
                                aspectRatio:
                                    state.value == Signs.addition ? 0.5 : 0.4,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    state.value == Signs.addition ? "+" : "−",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 75),
                                  ),
                                ),
                              );
                            }),
                          ))
                        : const SizedBox.shrink(),
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
