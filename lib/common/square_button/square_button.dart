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
      required this.width,
      required this.height});
  static const padding = 5.0;
  final double width;
  final double height;
  final bool unlocked;
  final Widget minature;
  final String text;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: BlocProvider(
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
                child: LayoutBuilder(
                  builder: (context, constrains) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(constrains.maxHeight * 0.1),
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
                          padding: EdgeInsets.all(padding *
                              MediaQuery.of(context).size.height /
                              1080),
                          child: SquareButtonContent(
                              padding: padding,
                              width: width,
                              height: height,
                              unlocked: unlocked,
                              minature: minature,
                              text: text),
                        )
                      ]),
                    );
                  },
                ),
              ),
            );
          },
        ),
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
      required this.padding});
  final double width;
  final double height;
  final bool unlocked;
  final Widget minature;
  final String text;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(constrains.maxHeight * 0.1 -
              padding * MediaQuery.of(context).size.height / 1080 / 2),
          clipBehavior: Clip.hardEdge,
          child: FittedBox(
            fit: BoxFit.fill,
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
                          child: FittedBox(
                            child: unlocked
                                ? minature
                                : FittedBox(
                                    fit: BoxFit.fill,
                                    child: Icon(Icons.lock,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer),
                                  ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                  fontWeight: FontWeight.bold),
                            ),
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
                    color: const Color.fromARGB(255, 103, 103, 103)
                        .withOpacity(0.8),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
