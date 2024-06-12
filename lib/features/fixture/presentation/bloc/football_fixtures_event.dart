part of 'football_fixtures_bloc.dart';

sealed class FootballFixturesEvent extends Equatable {
  const FootballFixturesEvent();

  @override
  List<Object> get props => [];
}

class FootballFetchFixtures extends FootballFixturesEvent {
  const FootballFetchFixtures();
}
