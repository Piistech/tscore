part of 'home_navigator_cubit.dart';

class HomeNavigatorState extends Equatable {
  final int currentIndex;

  const HomeNavigatorState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
