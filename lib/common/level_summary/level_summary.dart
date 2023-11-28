import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/level_summary/home_button.dart';
import 'package:matma/common/level_summary/next_button.dart';

class LevelSummary extends StatelessWidget {
  const LevelSummary({super.key, required this.next});
  final Widget? next;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
      child: Center(
        child: Stack(
          children: [
            const _LevelSummaryBackground(),
            _LevelSummaryContent(next: next),
          ],
        ),
      ),
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
        color: defaultEquator,
        width: 650,
        height: 410,
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
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: defaultBackground,
          width: 640,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  const Spacer(),
                  const HomeButton(),
                  if (next != null) ...[
                    const Spacer(),
                    NextButton(next: next),
                  ],
                  const Spacer(),
                  const Spacer(),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
