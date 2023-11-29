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
      this.textColor,
      required this.width,
      required this.height});
  static const padding = 5.0;
  final double width;
  final double height;
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
                  SizedBox(
                    width: width,
                    height: height,
                    child: state && unlocked
                        ? Container(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer)
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: SquareButtonContent(
                        width: width - padding * 2,
                        height: height - padding * 2,
                        unlocked: unlocked,
                        minature: minature,
                        textColor: textColor,
                        text: text),
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

class SquareButtonContent extends StatelessWidget {
  const SquareButtonContent(
      {super.key,
      required this.width,
      required this.height,
      required this.unlocked,
      required this.minature,
      required this.text,
      this.textColor});
  final double width;
  final double height;
  final bool unlocked;
  final Widget minature;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: FittedBox(child: minature),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (!unlocked)
            Container(
              width: width,
              height: height,
              color: const Color.fromARGB(255, 103, 103, 103).withOpacity(0.8),
            ),
        ],
      ),
    );
  }
}
