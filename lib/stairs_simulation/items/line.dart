import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/items/item.dart';

class Line extends Item {
  Line(super.index, super.unit, super.horizUnit);
  Color flatColor = Colors.grey;
  @override
  FutureOr<void> onLoad() {
    add(
      RectangleComponent(
          anchor: Anchor.centerLeft,
          size: Vector2(horizUnit - unit / 10, unit / 5),
          paint: Paint()..color = flatColor),
    );
    return super.onLoad();
  }
}
