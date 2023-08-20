import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/items/arrow_down.dart';
import 'package:matma/stairs_simulation/items/arrow_up.dart';
import 'package:matma/stairs_simulation/items/line.dart';
import 'package:matma/stairs_simulation/stairs_logic.dart';
import 'package:matma/stairs_simulation/starts_simulation.dart';

import 'items/item.dart';

// double scale = 0.5;
// Color arrowColor = Colors.blueAccent;
// Color flatColor = Colors.redAccent;
// double ballRadius = 13 * scale;
// double lineWidth = 10 * scale;
// double horizontalLineLength = 50 * scale;
// double lineLength = 100 * scale;
// int maxNumber = 10;

class StairsComponent extends PositionComponent
    with ParentIsA<StairsSimulation> {
  final List<Stair> stairs;

  StairsComponent(this.stairs);
  @override
  FutureOr<void> onLoad() {
    removeAll(children);
    //centerPoint
    var maxHeight = 7 * lineLength * 2;
    var pointer =
        Vector2(50, (parent.canvasSize.y - maxHeight) / 2 + maxHeight / 2);
    for (int i = 0; i < stairs.length; i++) {
      switch (stairs[i]) {
        case Stair.up:
          add(ArrowUp(i)
            ..position = pointer
            ..priority = 2);
          pointer += Vector2(0, -lineLength);
        case Stair.down:
          add(ArrowDown(i)
            ..position = pointer
            ..priority = 2);
          pointer += Vector2(0, lineLength);
        case Stair.flat:
          add(Line(i)..position = pointer);
          pointer += Vector2(horizontalLineLength, 0);
        default:
      }
    }

    return super.onLoad();
  }

  double timeSum = 0;

  @override
  void update(double dt) {
    timeSum += dt;
    if (timeSum > 0.02) {
      for (int i = stairs.length - 1; i >= 0; i--) {
        if (stairs[i] == Stair.futureFlat) {
          stairs[i] = Stair.flat;
          break;
        }
      }
      timeSum = 0;
    }
    onLoad();
    super.update(dt);
  }
}
