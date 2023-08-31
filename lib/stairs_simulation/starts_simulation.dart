import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/items/item.dart';
import 'package:matma/stairs_simulation/stairs_logic.dart';

class StepsSimulation extends FlameGame
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
    double unit = canvasSize.y / 18;
    double horizUnit = canvasSize.x / 66;
    //4 units text component
    add(TextComponent(
        text: stairs.toString(),
        textRenderer: TextPaint(
            style: TextStyle(fontSize: 2 * unit, fontWeight: FontWeight.bold)),
        position: Vector2(canvasSize.x / 2, 1.5 * unit),
        anchor: Anchor.center));
    //14 units stairs component
    add(stairs.generateStairsComponent(unit, horizUnit));

    // add(CircularButton(unit, "+"));

    // add(TextComponent(
    //     text: "+",
    //     textRenderer: TextPaint(style: TextStyle(fontSize: 2 * unit)),
    //     position: Vector2(canvasSize.x / 2, 1.5 * unit),
    //     anchor: Anchor.center));
    return super.onLoad();
  }
}
