import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/common/items/animations/tween_animated_size.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

class DefaultGameItemAnimations extends StatelessWidget {
  const DefaultGameItemAnimations(
      {super.key,
      required this.child,
      required this.initialState,
      required this.state,
      this.gs});
  final Widget child;
  final GameItemState initialState;
  final GameItemState state;
  final GameSize? gs;

  @override
  Widget build(BuildContext context) {
    return TweenAnimatedPosition(
      initialPosition: initialState.position.value
          .scale(gs != null ? gs!.wUnit : 1, gs != null ? gs!.hUnit : 1),
      updatedPosition: state.position.value
          .scale(gs != null ? gs!.wUnit : 1, gs != null ? gs!.hUnit : 1),
      duration: Duration(milliseconds: state.position.duration),
      child: AnimatedOpacity(
        opacity: state.opacity.value,
        duration: Duration(milliseconds: state.opacity.duration),
        child: TweenAnimatedSize(
            initialSize: initialState.size.value
                .scale(gs != null ? gs!.wUnit : 1, gs != null ? gs!.hUnit : 1),
            updatedSize: state.size.value
                .scale(gs != null ? gs!.wUnit : 1, gs != null ? gs!.hUnit : 1),
            duration: Duration(milliseconds: state.size.duration),
            child: child),
      ),
    );
  }
}
