import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/stairs_simulation_native/bloc/stairs_simulation_bloc.dart';
import 'package:matma/stairs_simulation_native/hoverable_items/arrow_path_generator.dart';

class HoverableArrowUp extends StatelessWidget {
  const HoverableArrowUp(
      {super.key,
      required this.width,
      required this.height,
      required this.id,
      required this.def,
      required this.hov});
  final double width;
  final double height;
  final UniqueKey id;
  final Color def;
  final Color hov;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<StepsSimulationBloc>();
    var sent = false;
    return Listener(
      onPointerDown: (event) {
        // _animateTo(0.3);
        if (!sent) {
          sent = true;
          bloc.add(StepsSimulationClick(id, DateTime.now()));
        } else {
          sent = true;
          bloc.add(StepsSimulationRetract(id, DateTime.now()));
          bloc.add(StepsSimulationClick(id, DateTime.now()));
        }
      },
      onPointerUp: (event) {
        // _animateTo(1);
        bloc.add(StepsSimulationClickEnd(id, DateTime.now()));
      },
      // onPointerCancel: (event) {
      //   print("CANCEL");
      //   bloc.add(StepsSimulationRetract(id, DateTime.now()));
      // },
      child: MouseRegion(
        onEnter: (p) {
          hoverKepper = id;
        },
        onExit: (p) {
          // setState(() {
          //   _color = def;
          // });
          hoverKepper = null;
        },
        hitTestBehavior: HitTestBehavior.deferToChild,
        child: BlocBuilder<StepsSimulationBloc, StepsSimulationState>(
          builder: (context, state) {
            var end = 1.0;
            var item = state.items.firstWhere(
              (element) => element.id == id,
            );
            if (item is StepSimulationItem) {
              end = item.gemmationProgress;
            }
            return TweenAnimationBuilder<double>(
              builder: (BuildContext context, double value, Widget? child) {
                return CustomPaint(
                  size: Size(width, height),
                  painter: _HoverableForm(
                      // color: _color ?? def,
                      color: def,
                      width: width,
                      height: height,
                      progress: value),
                );
              },
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
              tween: Tween(begin: 1.0, end: end),
              onEnd: () {
                if ((item as StepSimulationItem).gemmationProgress == 2.0) {
                  sent = false;
                  //TODO
                  bloc.add(
                      StepsSimulationClickAnimationDone(id, DateTime.now()));
                }
              },
            );
          },
        ),
      ),
    );
    // return Hoverable(
    //   def: const Color.fromARGB(255, 68, 157, 114),
    //   hov: const Color.fromARGB(255, 54, 126, 92),
    //   path: generateUpArrow(width / 15, width, height),
    //   width: width,
    //   height: height,
    //   id: id,
    // );
  }
}

// class HoverableArrowUp extends StatefulWidget {
//   const HoverableArrowUp(
//       {super.key,
//       required this.width,
//       required this.height,
//       required this.id,
//       required this.def,
//       required this.hov});
//   final double width;
//   final double height;
//   final UniqueKey id;
//   final Color def;
//   final Color hov;

//   @override
//   State<HoverableArrowUp> createState() => _HoverableArrowUpState();
// }

// class _HoverableArrowUpState extends State<HoverableArrowUp>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   double _progress = 0.5;
//   @override
//   void initState() {
//     // TODO: implement initState
//     _controller = AnimationController(
//       value: 0.5,
//       vsync: this,
//       duration: Duration(milliseconds: 2000),
//     );
//     _controller.addListener(() {
//       setState(() {
//         _progress = _controller.value;
//         print(_progress);
//       });
//     });
//     super.initState();
//   }

//   void _animateTo(double x) {
//     _controller.animateTo(x);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();

//     super.dispose();
//   }

//   Color? _color;
//   @override
//   Widget build(BuildContext context) {
//     var bloc = context.read<StepsSimulationBloc>();
//     return Listener(
//       onPointerDown: (event) {
//         _animateTo(0.3);
//         // bloc.add(StepsSimulationClick(widget.id, DateTime.now()));
//       },
//       onPointerUp: (event) {
//         _animateTo(1);
//         // bloc.add(StepsSimulationClickEnd(widget.id, DateTime.now()));
//       },
//       child: MouseRegion(
//         onEnter: (p) {
//           setState(() {
//             _color = widget.hov;
//           });
//           hoverKepper = widget.id;
//         },
//         onExit: (p) {
//           setState(() {
//             _color = widget.def;
//           });
//           hoverKepper = null;
//         },
//         hitTestBehavior: HitTestBehavior.deferToChild,
//         child: CustomPaint(
//           size: Size(widget.width, widget.height),
//           painter: _HoverableForm(
//               color: _color ?? widget.def,
//               width: widget.width,
//               height: widget.height,
//               progress: _progress),
//         ),
//       ),
//     );
//     // return Hoverable(
//     //   def: const Color.fromARGB(255, 68, 157, 114),
//     //   hov: const Color.fromARGB(255, 54, 126, 92),
//     //   path: generateUpArrow(width / 15, width, height),
//     //   width: width,
//     //   height: height,
//     //   id: id,
//     // );
//   }
// }

class _HoverableForm extends CustomPainter {
  Color color;

  final double progress;

  final double width;
  double height;

  Path path = Path();
  Path path2 = Path();

  _HoverableForm(
      {required this.progress,
      required this.color,
      required this.width,
      required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    var radius = width / 15;

    final tHeight = 3 * sqrt(3) / 6 * width;
    var xd1 = sqrt(3) * radius;
    var xd2 = sqrt(3) / 2 * radius;
    var yd = 3 / 2 * radius;

    path.moveTo(width * 1 / 2, tHeight);
    path.lineTo(width * 1 - xd1, tHeight);
    path.arcToPoint(Offset(width - xd2, tHeight - yd),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(width * 1 / 2 + xd2, 0 + yd);
    path.arcToPoint(Offset(width * 1 / 2 - xd2, 0 + yd),
        clockwise: false, radius: Radius.circular(radius));
    path.lineTo(0 + xd2, tHeight - yd);
    path.arcToPoint(Offset(0 + xd1, tHeight),
        clockwise: false, radius: Radius.circular(radius));
    path.lineTo(width * 1 / 2, tHeight);

    if (progress > 1.50) {
      var elo = (2 - progress) * width / 4;
      path2.moveTo(width * 1 / 2, tHeight + height);
      // path.moveTo(width * 1 / 2, tHeight);
      path2.lineTo(width * 1 - xd1 - elo, tHeight + height);
      path2.arcToPoint(Offset(width - xd2 - elo, tHeight - yd + height),
          radius: Radius.circular(radius), clockwise: false);
      path2.lineTo(width * 1 / 2 + xd2 - elo, 0 + yd + height);
      path2.arcToPoint(Offset(width * 1 / 2 - xd2 + elo, 0 + yd + height),
          clockwise: false, radius: Radius.circular(radius));
      path2.lineTo(0 + xd2 + elo, tHeight - yd + height);
      path2.arcToPoint(Offset(0 + xd1 + elo, tHeight + height),
          clockwise: false, radius: Radius.circular(radius));
      path2.lineTo(width * 1 / 2, tHeight + height);
      path2.moveTo(width * 1 / 2, tHeight);
    }

    path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0.25 * width, tHeight, width * 0.5,
            progress * height - tHeight + radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)));
    path = path.shift(Offset(0, -radius));
    // if (progress >= 0.25) {
    path = path.shift(Offset(0, -height * progress + height));

    path2 = path2.shift(Offset(0, -radius));
    // if (progress >= 0.25) {
    path2 = path2.shift(Offset(0, -height * progress + height));

//

    // 1 2 3 4
    // 0.1
    // double radius = width / 15;
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawPath(path2, Paint()..color = color);
  }

  @override
  bool? hitTest(Offset position) {
    return path.contains(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
