import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

class FloorState extends GameItemState {
  final Direction direction;
  bool isLastInNumber;
  bool isLastInGame;
  FloorState(
      {this.isLastInNumber = false,
      this.isLastInGame = false,
      required super.id,
      required super.position,
      required super.size,
      super.isHovered,
      required this.direction,
      required super.opacity,
      required super.radius});

  @override
  FloorState copyWith(
      {UniqueKey? id,
      Offset? position,
      Offset? size,
      bool? isHovered,
      double? opacity,
      double? radius,
      double? animProgress,
      bool? isLastInNumber,
      bool? isLastInGame}) {
    return FloorState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        radius: radius ?? this.radius,
        direction: direction,
        isLastInNumber: isLastInNumber ?? this.isLastInNumber,
        isLastInGame: isLastInGame ?? this.isLastInGame);
  }
}
