import 'package:bloc/bloc.dart';

class LevelIconCubit extends Cubit<bool> {
  LevelIconCubit() : super(false);

  void onHover() {
    emit(true);
  }

  void onHoverEnd() {
    emit(false);
  }
}
