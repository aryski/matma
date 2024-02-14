import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';

import 'package:matma/equation/equation.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';
import 'package:matma/quest/quests.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/game_items_displayer.dart';

class StepsGame extends StatelessWidget {
  const StepsGame({super.key, required this.data});
  final StepsGameData data;
  @override
  Widget build(BuildContext context) {
    final promptCubit =
        QuestsBloc(BlocProvider.of<LevelCubit>(context), data.firstTask);
    final eqCubit = EquationBloc(
        init: EquationState(),
        initNumbers: data.initNumbers,
        targetValues: data.withFixedEquation);
    final bloc = StepsGameBloc(eqCubit, promptCubit, data.allowedOps);
    return DefaultTextStyle(
      style: const TextStyle(),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<StepsGameBloc>(create: (context) => bloc),
            BlocProvider<EquationBloc>(create: (context) => eqCubit),
            BlocProvider<QuestsBloc>(create: (context) => promptCubit)
          ],
          child: _ScrollListener(
            bloc: bloc,
            child: _StepsGameContent(
              data: data,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollListener extends StatelessWidget {
  const _ScrollListener({
    required this.bloc,
    required this.child,
  });
  final StepsGameBloc bloc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent && hoverKepper != null) {
            bloc.add(
                StepsTrigEventScrollFloor(hoverKepper!, event.scrollDelta.dy));
          }
        },
        child: child);
  }
}

class _StepsGameContent extends StatelessWidget {
  const _StepsGameContent({
    required this.data,
  });
  final StepsGameData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1.0,
          child: Container(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        if (data.shadedSteps != null)
          ShadedGameItemsDisplayer(initNumbers: data.shadedSteps!),
        const Quests(),
        const GameItemsDisplayer(),
        if (data.withEquation) const Equation(),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: BackButton(),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                BlocProvider.of<LevelCubit>(context).refreshGame();
              },
            ),
          ),
        ),
      ],
    );
  }
}
