import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/global_cubits/theme_mode_cubit.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: () {
        var cubit = BlocProvider.of<ThemeModeCubit>(context);
        switch (cubit.state) {
          case ThemeMode.dark:
            cubit.updateThemeMode(ThemeMode.light);
            break;
          case ThemeMode.light:
            cubit.updateThemeMode(ThemeMode.dark);
            break;
          default:
        }
      },
      icon: Icon(
          (BlocProvider.of<ThemeModeCubit>(context).state == ThemeMode.dark)
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined),
    );
  }
}
