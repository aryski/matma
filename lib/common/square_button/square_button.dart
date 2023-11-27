import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/square_button/cubit/square_button_cubit.dart';

class SquareButton extends StatelessWidget {
  const SquareButton(
      {super.key,
      required this.unlocked,
      required this.minature,
      this.onTap,
      required this.text,
      this.textColor});
  final bool unlocked;
  final Widget minature;
  final String text;
  final Color? textColor;
  final void Function()? onTap;

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
              onTap: (unlocked) ? onTap : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.hardEdge,
                child: Stack(alignment: Alignment.center, children: [
                  state && unlocked
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
                                fit: BoxFit.contain,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    minature,
                                    Text(
                                      text,
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: textColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        unlocked
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
