import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/menu/level_icon/cubit/level_icon_cubit.dart';

class LevelIcon extends StatelessWidget {
  const LevelIcon(
      {super.key,
      required this.active,
      required this.level,
      required this.title,
      required this.minature});
  final bool active;
  final Widget level;
  final String title;
  final Widget minature;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LevelIconCubit(),
      child: BlocBuilder<LevelIconCubit, bool>(
        builder: (context, state) {
          return MouseRegion(
            hitTestBehavior: HitTestBehavior.deferToChild,
            onEnter: (event) {
              context.read<LevelIconCubit>().onHover();
            },
            onExit: (event) {
              context.read<LevelIconCubit>().onHoverEnd();
            },
            child: GestureDetector(
              onTap: () {
                if (active) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => level));
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.hardEdge,
                child: Stack(alignment: Alignment.center, children: [
                  state && active
                      ? Container(
                          //tutaj jakis canvasik z rysuneczkiem
                          width: 210,
                          height: 210,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )
                      : const SizedBox(
                          width: 210,
                          height: 210,
                        ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            //tutaj jakis canvasik z rysuneczkiem
                            width: 200,
                            height: 200,
                            color: Colors.amberAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: FittedBox(
                                child: minature,
                                fit: BoxFit.contain,
                              ),
                            )),
                        active
                            ? const SizedBox.shrink()
                            : Container(
                                //tutaj jakis canvasik z rysuneczkiem
                                width: 200,
                                height: 200,
                                color: const Color.fromARGB(255, 103, 103, 103)
                                    .withOpacity(0.8),
                              ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
