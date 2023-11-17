import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/menu/level_icon/level_icon.dart';

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
            _LevelSummaryForeground(next: next),
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

class _LevelSummaryForeground extends StatelessWidget {
  const _LevelSummaryForeground({
    required this.next,
  });

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
                'Ukończyłeś poziom',
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  const Spacer(),
                  const _SummaryMenuButton(),
                  if (next != null) ...[
                    const Spacer(),
                    _SummaryNextButton(next: next),
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

class _SummaryNextButton extends StatelessWidget {
  const _SummaryNextButton({
    required this.next,
  });

  final Widget? next;

  @override
  Widget build(BuildContext context) {
    return LevelButton(
      unlocked: true,
      onTap: () {
        if (next != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => next!));
        }
      },
      minature: const Icon(
        Icons.keyboard_double_arrow_right_rounded,
        size: 150,
      ),
      text: 'Następny',
      textColor: Colors.black87,
    );
  }
}

class _SummaryMenuButton extends StatelessWidget {
  const _SummaryMenuButton();

  @override
  Widget build(BuildContext context) {
    return LevelButton(
      unlocked: true,
      onTap: () {
        Navigator.pop(context);
      },
      minature: const Icon(
        Icons.home_filled,
        size: 150,
      ),
      text: 'Menu',
      textColor: Colors.black87,
    );
  }
}
