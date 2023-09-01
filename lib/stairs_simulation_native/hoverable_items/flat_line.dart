import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation_native/hoverable_items/hoverable.dart';

Path _generateFlatLine(double radius, double width, double height) {
  var path = Path();
  return path
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width, height),
        Radius.circular(radius),
      ),
    );
}

class HoverableFlatLine extends StatelessWidget {
  const HoverableFlatLine(
      {super.key,
      required this.width,
      required this.height,
      required this.id,
      required this.radius});
  final double width;
  final double height;
  final UniqueKey id;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      def: Colors.grey,
      hov: const Color.fromARGB(255, 112, 112, 112),
      path: _generateFlatLine(radius, width, height),
      width: width,
      height: height,
      id: id,
    );
  }
}
