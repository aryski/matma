import 'package:flutter/material.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/common/items/animations/tween_animated_size.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

class DefaultGameItemAnimations extends StatelessWidget {
  const DefaultGameItemAnimations({
    super.key,
    required this.child,
    required this.initialState,
    required this.state,
    this.noResize = false,
    this.halfWidthOffset = false,
    this.halfHeightOffset = true,
  });
  final Widget child;
  final GameItemState initialState;
  final GameItemState state;
  final bool noResize;
  final bool halfWidthOffset;
  final bool halfHeightOffset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return TweenAnimatedPosition(
        halfHeightOffset: halfHeightOffset,
        halfWidthOffset: halfWidthOffset,
        noResize: noResize,
        initialPosition: initialState.position.value,
        updatedPosition: state.position.value,
        duration: Duration(milliseconds: state.position.duration),
        child: AnimatedOpacity(
          opacity: state.opacity.value,
          duration: Duration(milliseconds: state.opacity.duration),
          child: TweenAnimatedSize(
              noResize: noResize,
              maxX: constraints.maxWidth,
              maxY: constraints.maxHeight,
              initialSize: initialState.size.value,
              updatedSize: state.size.value,
              duration: Duration(milliseconds: state.size.duration),
              child: child),
        ),
      );
    });
  }
}
