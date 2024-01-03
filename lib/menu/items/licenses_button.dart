import 'package:flutter/material.dart';
import 'package:matma/color_schemes.g.dart';

class LicensesButton extends StatelessWidget {
  const LicensesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)))),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Theme(
                        data: ThemeData(
                            useMaterial3: true,
                            textTheme: Typography.dense2021,
                            colorScheme: lightColorScheme),
                        child: const LicensePage(
                          applicationName: "Matma",
                          applicationVersion: "1.1",
                          applicationIcon: Image(
                              image: AssetImage(
                                  "web/icons/Icon-maskable-192.png")),
                          applicationLegalese: "Copyright (c) 2023 Adam Ryski",
                        ),
                      )));
        },
        child: const Text("Licencje"));
  }
}
