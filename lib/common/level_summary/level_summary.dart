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
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
            width: 570,
            height: 320,
            child: Center(
              child: _Board(
                child: _LevelSummaryContent(next: next),
              ),
            ));
      },
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Theme.of(context).colorScheme.onBackground,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: child,
            ),
          ),
        ),
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
    return DefaultTextStyle(
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 30.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const HomeButton(
              sideWidth: 160,
            ),
            if (next != null) ...[
              const SizedBox(height: 30.0),
              NextButton(
                next: next,
                sideWidth: 160,
              )
            ]
          ]),
        ],
      ),
    );
  }
}
