part of 'football_fixtures_bloc.dart';

sealed class FootballFixturesState extends Equatable {
  const FootballFixturesState();

  @override
  List<Object> get props => [];
}

final class FootballFixturesInitial extends FootballFixturesState {}

class FootballFixturesLoading extends FootballFixturesState {
  const FootballFixturesLoading();
}

class FootballFixturesError extends FootballFixturesState {
  final Failure failure;

  const FootballFixturesError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FootballFixturesDone extends FootballFixturesState {
  final List<FixturesEntity> fixtures;

  const FootballFixturesDone({
    required this.fixtures,
  });

  @override
  List<Object> get props => [fixtures];
}
