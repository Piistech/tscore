part of 'cricket_fixtures_bloc.dart';

abstract class CricketFixturesState extends Equatable {
  const CricketFixturesState();

  @override
  List<Object> get props => [];
}

class CricketFixturesInitial extends CricketFixturesState {
  const CricketFixturesInitial();
}

class CricketFixturesLoading extends CricketFixturesState {
  const CricketFixturesLoading();
}

class CricketFixturesError extends CricketFixturesState {
  final Failure failure;

  const CricketFixturesError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class CricketFixturesDone extends CricketFixturesState {
  final List<FixturesEntity> fixtures;

  const CricketFixturesDone({
    required this.fixtures,
  });

  @override
  List<Object> get props => [fixtures];
}
