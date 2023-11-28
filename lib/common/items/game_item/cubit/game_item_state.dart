import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';

abstract class GameItemState {
  final UniqueKey id;
  final AnimatedProp<Offset> position;
  final AnimatedProp<Offset> size;
  final bool isHovered;
  final AnimatedProp<double> opacity;
  final double radius;

  GameItemState(
      {required this.id,
      required this.position,
      required this.size,
      this.isHovered = false,
      required this.opacity,
      required this.radius});

  GameItemState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double radius});
}
