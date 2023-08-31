import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';


class CircularButton extends ButtonComponent {
  final double unit;
  final String text;

  CircularButton(this.unit, this.text);

  // CircularButton(this.unit, this.text);

  @override
  FutureOr<void> onLoad() {
    add(CircleComponent(radius: 10, paint: Paint()..color = Colors.redAccent));
    add(TextComponent(
      text: text,
      textRenderer: TextPaint(style: TextStyle(fontSize: 2 * unit)),
      anchor: Anchor.bottomCenter,
    ));
    // TODO: implement onLoad
    return super.onLoad();
  }
}


// ButtonComponent(
//         position: Vector2(6 * horizUnit, canvasSize.y - 3 * unit),
//         anchor: Anchor.center,
//         button: CircleComponent(
//             anchor: Anchor.center,
//             radius: unit,
//             paint: Paint()..color = Colors.greenAccent,
//             children: [
              
//             ]),
//         onPressed: () {
//           stairs.addOnEnd();
//           onLoad();
//         },
//       ),
//     );