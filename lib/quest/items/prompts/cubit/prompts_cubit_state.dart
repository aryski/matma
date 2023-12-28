import 'package:matma/quest/items/line/cubit/line_cubit.dart';

class PromptsState {
  final List<LineCubit> lines;

  PromptsState({required this.lines});

  PromptsState copyWith({List<LineCubit>? lines}) {
    return PromptsState(lines: lines != null ? [...lines] : []);
  }
}
