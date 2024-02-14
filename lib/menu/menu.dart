import 'package:flutter/material.dart';
import 'package:matma/menu/items/level_picker.dart';
import 'package:matma/menu/items/licenses_button.dart';
import 'package:matma/menu/items/logo.dart';
import 'package:matma/menu/items/theme_mode_button.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 80,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ThemeModeButton(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 110, maxWidth: 500),
                    child: const Logo(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: SizedBox(
                        height: 45,
                        child: Text(
                          "Dodawanie i odejmowanie",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                LayoutBuilder(builder: (context, constrains) {
                  if (constrains.maxWidth > 1000) {
                    return const SizedBox(
                      height: 160,
                      child: Center(child: LevelPicker()),
                    );
                  } else {
                    return const SizedBox(
                      height: 120,
                      child: Center(child: LevelPicker()),
                    );
                  }
                }),
                const Spacer(),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LicensesButton(),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
