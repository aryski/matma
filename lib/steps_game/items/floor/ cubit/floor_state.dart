import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

enum FloorColors { def, special }

class FloorState extends GameItemState {
  final Direction direction;
  bool isLastInNumber;
  AnimatedProp<FloorColors> colors;
  FloorState(
      {this.isLastInNumber = false,
      required super.id,
      required super.position,
      required super.size,
      super.isHovered,
      required this.direction,
      required super.opacity,
      required this.colors});

  @override
  FloorState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      double? animProgress,
      bool? isLastInNumber,
      AnimatedProp<FloorColors>? colors,
      int? millis}) {
    return FloorState(
      id: id ?? this.id,
      isHovered: isHovered ?? this.isHovered,
      position: position ?? this.position,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
      direction: direction,
      isLastInNumber: isLastInNumber ?? this.isLastInNumber,
      colors: colors ?? this.colors,
    );
  }
}
