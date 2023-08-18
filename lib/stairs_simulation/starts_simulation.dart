import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/items/item.dart';
import 'package:matma/stairs_simulation/stairs_logic.dart';

class StairsSimulation extends FlameGame
    with ScrollDetector, MouseMovementDetector {
  final Stairs stairs = Stairs([4, -2, 1, -3]);

  @override
  Color backgroundColor() => const Color.fromARGB(255, 251, 237, 237);
  @override
  void onScroll(PointerScrollInfo info) {
    componentsAtPoint(info.eventPosition.game).forEach((element) {
      double diff = info.scrollDelta.global.y / 100;
      int diffNormalized = 0;
      if (diff > 0) {
        diffNormalized = diff.ceil();
      } else {
        diffNormalized = diff.floor();
      }
      var arrowComponent = element.parent;
      if (arrowComponent is Item) {
        stairs.scroll(arrowComponent.index, diffNormalized);
      }
    });
    onLoad();
    super.onScroll(info);
  }

  @override
  FutureOr<void> onLoad() {
    removeAll(children);
    // var unit = canvasSize.y / 40; TODO

    add(TextComponent(
        text: stairs.toString(),
        textRenderer: TextPaint(style: TextStyle(fontSize: 80)),
        position: Vector2(canvasSize.x / 2, 100),
        anchor: Anchor.center));
    add(stairs.generateStairsComponent());
    return super.onLoad();
  }
}
