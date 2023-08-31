import 'dart:async';

import 'package:flame/components.dart';
import 'package:matma/stairs_simulation/items/arrow_down.dart';
import 'package:matma/stairs_simulation/items/arrow_up.dart';
import 'package:matma/stairs_simulation/items/line.dart';
import 'package:matma/stairs_simulation/stairs_logic.dart';
import 'package:matma/stairs_simulation/starts_simulation.dart';


// double scale = 0.5;
// Color arrowColor = Colors.blueAccent;
// Color flatColor = Colors.redAccent;
// double ballRadius = 13 * scale;
// double lineWidth = 10 * scale;
// double horizontalLineLength = 50 * scale;
// double lineLength = 100 * scale;
// int maxNumber = 10;

class StairsComponent extends PositionComponent
    with ParentIsA<StepsSimulation> {
  final List<Stair> stairs;
  double unit;
  double horizUnit;

  StairsComponent(this.stairs, this.unit, this.horizUnit);

  @override
  FutureOr<void> onLoad() {
    removeAll(children);
    //centerPoint
    var pointer = Vector2(3 * horizUnit, 10 * unit);
    for (int i = 0; i < stairs.length; i++) {
      switch (stairs[i]) {
        case Stair.up:
          add(ArrowUp(i, unit, horizUnit)
            ..position = pointer
            ..priority = 2);
          pointer += Vector2(0, -unit);
        case Stair.down:
          add(ArrowDown(i, unit, horizUnit)
            ..position = pointer
            ..priority = 2);
          pointer += Vector2(0, unit);
        case Stair.flat:
          add(Line(i, unit, horizUnit)..position = pointer);
          pointer += Vector2(horizUnit, 0);
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
