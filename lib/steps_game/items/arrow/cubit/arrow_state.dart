import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

enum Direction { up, down }

class ArrowState extends GameItemState {
  final Direction direction;
  final double animProgress;
  ArrowState(
      {required super.id,
      required super.position,
      required super.size,
      super.isHovered,
      required super.opacity,
      required this.direction,
      required this.animProgress});

  @override
  ArrowState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      double? animProgress}) {
    return ArrowState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        isHovered: isHovered ?? this.isHovered,
        opacity: opacity ?? this.opacity,
        direction: direction,
        animProgress: animProgress ?? this.animProgress);
  }
}
