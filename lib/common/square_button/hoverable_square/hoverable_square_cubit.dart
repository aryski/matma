import 'package:bloc/bloc.dart';

class HoverableSquareCubit extends Cubit<bool> {
  HoverableSquareCubit() : super(false);

  void onHover() {
    emit(true);
  }

  void onHoverEnd() {
    emit(false);
  }
}
