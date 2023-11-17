import 'package:matma/prompts/items/line/cubit/line_cubit.dart';

class QuestsState {
  final List<LineCubit> lines;

  QuestsState({required this.lines});

  QuestsState copyWith({List<LineCubit>? lines}) {
    return QuestsState(lines: lines != null ? [...lines] : []);
  }
}
