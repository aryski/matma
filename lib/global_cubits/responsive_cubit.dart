import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Breakpoint { mobile, tablet, desktopSmall, desktop }

extension BreakPointSizes on Breakpoint {
  double get fontSize {
    switch (this) {
      case Breakpoint.mobile:
        return 12.0;
      case Breakpoint.tablet:
        return 15.0;
      case Breakpoint.desktopSmall:
        return 20.0;
      case Breakpoint.desktop:
        return 25.0;
    }
  }
}

Breakpoint screenSizeToBreakpoint(double dx, double dy) {
  if (dx > 1600) {
    if (dy > 900) {
      return Breakpoint.desktop;
    } else {
      return Breakpoint.desktopSmall;
    }
  } else {
    return Breakpoint.desktopSmall;
  }
}

class ResponsiveCubit extends Cubit<Breakpoint> {
  ResponsiveCubit(double dx, double dy) : super(screenSizeToBreakpoint(dx, dy));

  Breakpoint get size => state;

  void updateScreenSize(double dx, double dy) {
    emit(screenSizeToBreakpoint(dx, dy));
  }
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, Breakpoint bp) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponsiveCubit, Breakpoint>(
      builder: (context, state) {
        return builder(context, state);
      },
    );
  }
}
