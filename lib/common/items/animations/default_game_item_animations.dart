import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/common/items/animations/tween_animated_size.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

class DefaultGameItemAnimations extends StatelessWidget {
  const DefaultGameItemAnimations(
      {super.key,
      required this.child,
      required this.initialState,
      required this.state});
  final Widget child;
  final GameItemState initialState;
  final GameItemState state;

  @override
  Widget build(BuildContext context) {
    return TweenAnimatedPosition(
      initialPosition: initialState.position.value,
      updatedPosition: state.position.value,
      duration: Duration(milliseconds: state.position.duration),
      child: AnimatedOpacity(
        opacity: state.opacity.value,
        duration: Duration(milliseconds: state.opacity.duration),
        child: TweenAnimatedSize(
            initialSize: initialState.size.value,
            updatedSize: state.size.value,
            duration: Duration(milliseconds: state.size.duration),
            child: child),
      ),
    );
  }
}
