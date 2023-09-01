import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/stairs_simulation_native/bloc/stairs_simulation_bloc.dart';

class Hoverable extends StatefulWidget {
  const Hoverable(
      {super.key,
      required this.def,
      required this.hov,
      required this.path,
      required this.width,
      required this.height,
      required this.id});
  final Color def;
  final Color hov;
  final Path path;
  final double width;
  final double height;
  final UniqueKey id;

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  Color? _color;
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<StepsSimulationBloc>();
    return Listener(
      onPointerDown: (event) {
        bloc.add(StepsSimulationClick(widget.id, DateTime.now()));
      },
      onPointerUp: (event) {
        bloc.add(StepsSimulationClickEnd(widget.id, DateTime.now()));
      },
      child: MouseRegion(
        onEnter: (p) {
          setState(() {
            _color = widget.hov;
          });
          hoverKepper = widget.id;
        },
        onExit: (p) {
          setState(() {
            _color = widget.def;
          });
          hoverKepper = null;
        },
        hitTestBehavior: HitTestBehavior.deferToChild,
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _HoverableForm(
              color: _color ?? widget.def,
              width: widget.width,
              height: widget.height,
              path: widget.path),
        ),
      ),
    );
  }
}

// class HoverableCubit extends Cubit<Color> {
//   final Color def;
//   final Color hov;
//   HoverableCubit(this.def, this.hov) : super(def);

//   void setDef() => emit(def);
//   void setHov() => emit(hov);
// }

// class Hoverable extends StatelessWidget {
//   final Color def;
//   final Color hov;
//   final Path path;
//   final double width;
//   final double height;
//   final int id;

//   const Hoverable(
//       {super.key,
//       required this.def,
//       required this.hov,
//       required this.path,
//       required this.width,
//       required this.height,
//       required this.id});

//   @override
//   Widget build(BuildContext context) {
//     var cubit = HoverableCubit(def, hov);
//     return BlocProvider(
//       create: (context) => cubit,
//       child: MouseRegion(
//         onEnter: (p) {
//           print("ENTER $id");
//           cubit.setHov();
//           hoverKepper = id;
//         },
//         onExit: (p) {
//           print("EXIT $id");
//           cubit.setDef();
//           hoverKepper = null;
//         },
//         hitTestBehavior: HitTestBehavior.deferToChild,
//         child: BlocBuilder<HoverableCubit, Color>(
//           builder: (context, color) {
//             return CustomPaint(
//               size: Size(width, height),
//               painter: _HoverableForm(
//                   color: color, width: width, height: height, path: path),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class _HoverableForm extends CustomPainter {
  Color color;
  final Path path;

  final double width;
  double height;

  _HoverableForm(
      {required this.path,
      required this.color,
      required this.width,
      required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    // double radius = width / 15;
    canvas.drawPath(path, Paint()..color = color);
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
