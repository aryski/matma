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
    this.halfWidthOffset = false,
    this.halfHeightOffset = true,
    this.bottomPositioning = false,
  });
  final Widget child;
  final GameItemState initialState;
  final GameItemState state;

  final bool halfWidthOffset;
  final bool halfHeightOffset;
  final bool bottomPositioning;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return TweenAnimatedPosition(
        halfHeightOffset: halfHeightOffset,
        halfWidthOffset: halfWidthOffset,
        initialPosition: initialState.position.value,
        updatedPosition: state.position.value,
        bottomPositioning: bottomPositioning,
        duration: Duration(milliseconds: state.position.millis),
        child: AnimatedOpacity(
          opacity: state.opacity.value,
          duration: Duration(milliseconds: state.opacity.millis),
          child: TweenAnimatedSize(
              initialSize: initialState.size.value,
              updatedSize: state.size.value,
              duration: Duration(milliseconds: state.size.millis),
              child: child),
        ),
      );
    });
  }
}
