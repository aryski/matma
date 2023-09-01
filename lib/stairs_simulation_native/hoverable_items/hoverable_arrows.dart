import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation_native/hoverable_items/arrow_path_generator.dart';
import 'package:matma/stairs_simulation_native/hoverable_items/hoverable.dart';

// class HoverableArrowUp extends StatelessWidget {
//   const HoverableArrowUp(
//       {super.key, required this.width, required this.height, required this.id});
//   final double width;
//   final double height;
//   final UniqueKey id;

//   @override
//   Widget build(BuildContext context) {
//     return Hoverable(
//       def: const Color.fromARGB(255, 68, 157, 114),
//       hov: const Color.fromARGB(255, 54, 126, 92),
//       path: generateUpArrow(width / 15, width, height),
//       width: width,
//       height: height,
//       id: id,
//     );
//   }
// }

class HoverableArrowDown extends StatefulWidget {
  const HoverableArrowDown(
      {super.key, required this.width, required this.height, required this.id});
  final double width;
  final double height;
  final UniqueKey id;

  @override
  State<HoverableArrowDown> createState() => _HoverableArrowDownState();
}

class _HoverableArrowDownState extends State<HoverableArrowDown> {
  @override
  Widget build(BuildContext context) {
    return Hoverable(
      def: Colors.redAccent,
      hov: const Color.fromARGB(255, 185, 60, 60),
      path: generateDownArrow(widget.width / 15, widget.width, widget.height),
      width: widget.width,
      height: widget.height,
      id: widget.id,
    );
  }
}
