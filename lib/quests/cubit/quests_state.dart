abstract class QuestsState {
  final String text;

  QuestsState({required this.text});
}

class QuestsStateDisplay extends QuestsState {
  QuestsStateDisplay({required super.text});
}

class QuestsStateEndLevel extends QuestsState {
  QuestsStateEndLevel({required super.text});
}
