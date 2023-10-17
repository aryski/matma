import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/levels/levels/level2.dart';
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: defaultEquator,
                width: 650,
                height: 410,
              ),
            ),
            Padding(
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
                          LevelButton(
                            unlocked: true,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            minature: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home_filled,
                                  size: 150,
                                ),
                                Text(
                                  'Menu',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          if (next != null) ...[
                            const Spacer(),
                            LevelButton(
                              unlocked: true,
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => next!));
                              },
                              minature: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.keyboard_double_arrow_right_rounded,
                                    size: 150,
                                  ),
                                  Text(
                                    'Następny',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
