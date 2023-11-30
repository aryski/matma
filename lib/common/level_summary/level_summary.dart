import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:matma/common/level_summary/home_button.dart';
import 'package:matma/common/level_summary/next_button.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';

class LevelSummary extends StatelessWidget {
  const LevelSummary({super.key, required this.next, required this.data});

  final Widget? next;
  final LevelData data;

  @override
  Widget build(BuildContext context) {
    Hive.box<bool>('levels').put(data.ind + 1, true);
    print("putting ind ${data.ind}");
    return Column(
      children: [
        const Spacer(flex: 5),
        Flexible(
          flex: 7,
          child: DefaultTextStyle(
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            child: Center(
              child: Row(
                children: [
                  const Spacer(),
                  Flexible(
                    flex: 1,
                    child: Stack(
                      children: [
                        const _LevelSummaryBackground(),
                        _LevelSummaryContent(next: next),
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ),
        const Spacer(flex: 5),
      ],
    );
  }
}

class _LevelSummaryBackground extends StatelessWidget {
  const _LevelSummaryBackground();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}

class _LevelSummaryContent extends StatelessWidget {
  const _LevelSummaryContent({
    required this.next,
  });

  static const text = "Ukończyłeś poziom.";

  final Widget? next;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Flexible(
                      flex: 3,
                      child: Text(
                        text,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              const Spacer(flex: 3),
              Flexible(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: next != null
                      ? [
                          const Spacer(flex: 3),
                          const Flexible(flex: 4, child: HomeButton()),
                          const Spacer(flex: 2),
                          Flexible(flex: 4, child: NextButton(next: next)),
                          const Spacer(flex: 3),
                        ]
                      : [
                          const Spacer(flex: 6),
                          const Flexible(flex: 4, child: HomeButton()),
                          const Spacer(flex: 6),
                        ],
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
