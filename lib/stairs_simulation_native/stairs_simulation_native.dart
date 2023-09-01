import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/stairs_simulation_native/bloc/stairs_simulation_bloc.dart';

import 'package:matma/stairs_simulation_native/hoverable_items/flat_line.dart';
import 'package:matma/stairs_simulation_native/hoverable_items/hoverable_arrow_up.dart';
import 'package:matma/stairs_simulation_native/hoverable_items/hoverable_arrows.dart';

class StepsSimulationNative extends StatelessWidget {
  final double width;
  final double height;

  const StepsSimulationNative(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    double unit = height / 18;
    double horizUnit = width / 66;
    var bloc = StepsSimulationBloc([7, -4, 1, -3], unit, horizUnit, 15, 60);
    return BlocProvider(
      create: (context) => bloc,
      child: SizedBox(
        width: width,
        height: height,
        child: Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              if (hoverKepper != null) {
                bloc.add(
                    StepsSimulationScroll(hoverKepper!, event.scrollDelta.dy));
              }
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 3 * unit,
                child: BlocBuilder<StepsSimulationBloc, StepsSimulationState>(
                  builder: (context, state) {
                    return Text(state.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 2 * unit,
                            fontWeight: FontWeight.bold,
                            color: Colors.black));
                  },
                ),
              ),
              SizedBox(
                height: 15 * unit,
                width: 60 * horizUnit,
                child: BlocBuilder<StepsSimulationBloc, StepsSimulationState>(
                  builder: (context, state) {
                    return Stack(children: [
                      ...state.items.map(
                        (e) {
                          return e.generateWidget();
                          // return AnimatedPositioned(
                          //   key: e.id,
                          //   curve: Curves.decelerate,
                          //   duration: Duration(milliseconds: 200),
                          //   top: e.position.dy,
                          //   left: e.position.dx,
                          //   child: AnimatedOpacity(
                          //     duration: const Duration(milliseconds: 200),
                          //     opacity: e.opacity,
                          //     child: (e is FlatSimulationItem &&
                          //             e.orientation == Direction.up)
                          //         ? HoverableFlatLine(
                          //             width: e.width,
                          //             height: e.height,
                          //             radius: e.radius,
                          //             id: e.id,
                          //           )
                          //         : (e is FlatSimulationItem &&
                          //                 e.orientation == Direction.down)
                          //             ? HoverableFlatLine(
                          //                 width: e.width,
                          //                 height: e.height,
                          //                 radius: e.radius,
                          //                 id: e.id,
                          //               )
                          //             : (e is StepSimulationItem &&
                          //                     e.orientation == Direction.up)
                          //                 ? AnimatedScale(
                          //                     alignment: Alignment.bottomCenter,
                          //                     scale: e.opacity,
                          //                     curve: Curves.easeIn,
                          //                     duration: const Duration(
                          //                         milliseconds: 200),
                          //                     child: HoverableArrowUp(
                          //                       def: const Color.fromARGB(
                          //                           255, 68, 157, 114),
                          //                       hov: const Color.fromARGB(
                          //                           255, 54, 126, 92),
                          //                       width: e.width,
                          //                       height: e.height,
                          //                       id: e.id,
                          //                     ))
                          //                 : AnimatedScale(
                          //                     alignment: Alignment.topCenter,
                          //                     scale: e.opacity,
                          //                     curve: Curves.easeIn,
                          //                     duration: const Duration(
                          //                         milliseconds: 200),
                          //                     child:
                          //                         ((e is StepSimulationItem &&
                          //                                 e.orientation ==
                          //                                     Direction.down)
                          //                             ? AnimatedScale(
                          //                                 alignment: Alignment
                          //                                     .topCenter,
                          //                                 duration:
                          //                                     const Duration(
                          //                                         milliseconds:
                          //                                             2000),
                          //                                 scale:
                          //                                     e.height / unit,
                          //                                 child:
                          //                                     HoverableArrowDown(
                          //                                   width: e.width,
                          //                                   height: e.height,
                          //                                   id: e.id,
                          //                                 ),
                          //                               )
                          //                             : const SizedBox
                          //                                 .shrink()),
                          //                   ),
                          //   ),
                          // );
                        },
                      ),
                      // ...state.items.map(
                      //   (e) {
                      //     return AnimatedPositioned(
                      //       key: e.id,
                      //       curve: Curves.decelerate,
                      //       duration: e.positionDuration,
                      //       top: e.position.dy,
                      //       left: e.position.dx,
                      //       child: AnimatedOpacity(
                      //         duration: const Duration(milliseconds: 200),
                      //         opacity: e.opacity,
                      //         child:
                      //       ),
                      //     );
                      //   },
                      // ),
                    ]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
