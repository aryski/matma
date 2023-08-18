import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/items/item.dart';

class Line extends Item {
  Line(super.index);

  @override
  FutureOr<void> onLoad() {
    add(
      RectangleComponent(
          anchor: Anchor.centerLeft,
          size: Vector2(horizontalLineLength, lineWidth),
          paint: Paint()..color = flatColor),
    );
    return super.onLoad();
  }
}
