import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';
import 'package:matma/quest/items/prompts/presentation/prompts.dart';

class Quests extends StatelessWidget {
  const Quests({super.key});

  @override
  Widget build(BuildContext context) {
    return Prompts(
      cubit: BlocProvider.of<QuestsBloc>(context).promptsCubit,
    );
  }
}
