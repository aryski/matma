import 'package:flutter/material.dart';

abstract class GameItemState {
  UniqueKey id;
  Offset position;
  Offset size;
  bool isHovered;
  double opacity;
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
      Offset? position,
      Offset? size,
      bool? isHovered,
      double? opacity,
      double? radius});
}
