import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'level_icon_state.dart';

class LevelIconCubit extends Cubit<bool> {
  LevelIconCubit() : super(false);

  void onHover() {
    emit(true);
  }

  void onHoverEnd() {
    emit(false);
  }
}
