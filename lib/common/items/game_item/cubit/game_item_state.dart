import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';

abstract class GameItemState {
  UniqueKey id;
  AnimatedProp<Offset> position;
  AnimatedProp<Offset> size;
  bool isHovered;
  AnimatedProp<double> opacity;
  double radius;

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
