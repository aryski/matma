import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/items/item.dart';

class ArrowDown extends Item {
  ArrowDown(super.index);

  @override
  FutureOr<void> onLoad() {
    add(RectangleComponent(
      anchor: Anchor.topCenter,
      size: Vector2(lineWidth, lineLength),
      paint: Paint()..color = arrowColor,
      priority: 3,
    ));

    add(
      PolygonComponent(
        [
          Vector2(-ballRadius, -ballRadius),
          Vector2(0, ballRadius),
          Vector2(ballRadius, -ballRadius)
        ],
        position: Vector2(0, lineLength),
        anchor: Anchor.center,
        paint: Paint()..color = arrowColor,
        priority: 3,
      ),
    );
    return super.onLoad();
  }
}
