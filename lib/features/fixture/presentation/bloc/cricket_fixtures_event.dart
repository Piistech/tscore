part of 'cricket_fixtures_bloc.dart';

abstract class CricketFixturesEvent extends Equatable {
  const CricketFixturesEvent();

  @override
  List<Object> get props => [];
}

class CricketFetchFixtures extends CricketFixturesEvent {
  const CricketFetchFixtures();
}
