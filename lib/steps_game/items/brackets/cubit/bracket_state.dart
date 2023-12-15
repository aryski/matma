import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

class BracketState extends GameItemState {
  final Direction direction;
  final double heightOffset;
  bool isLastInNumber;
  bool isLastInGame;
  BracketState(
      {this.isLastInNumber = false,
      this.isLastInGame = false,
      required super.id,
      required super.position,
      required super.size,
      super.isHovered,
      required this.direction,
      required super.opacity,
      required super.radius,
      required this.heightOffset});

  @override
  BracketState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      double? animProgress,
      bool? isLastInNumber,
      bool? isLastInGame,
      double? heightOffset}) {
    return BracketState(
        id: id ?? this.id,
        isHovered: isHovered ?? this.isHovered,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        radius: radius ?? this.radius,
        direction: direction,
        isLastInNumber: isLastInNumber ?? this.isLastInNumber,
        isLastInGame: isLastInGame ?? this.isLastInGame,
        heightOffset: heightOffset ?? this.heightOffset);
  }
}
