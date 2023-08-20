import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/items/item.dart';

class ArrowUp extends Item {
  ArrowUp(super.index, super.unit, super.horizUnit);

  @override
  FutureOr<void> onLoad() {
    add(RectangleComponent(
      anchor: Anchor.bottomCenter,
      size: Vector2(unit / 5, unit),
      paint: Paint()..color = arrowColor,
      priority: 3,
    ));
    var arrowRadius = unit / 4;
    add(
      PolygonComponent(
        [
          Vector2(-arrowRadius, arrowRadius),
          Vector2(arrowRadius, arrowRadius),
          Vector2(0, -arrowRadius)
        ],
        position: Vector2(0, -unit),
        anchor: Anchor.center,
        paint: Paint()..color = arrowColor,
        priority: 3,
      ),
    );
    return super.onLoad();
  }
}
