import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_navigator_state.dart';

class HomeNavigatorCubit extends Cubit<int> {
  HomeNavigatorCubit() : super(0);

  void setCurrentIndex(int index) {
    emit(index);
  }

  int get currentIndex => state;
}
