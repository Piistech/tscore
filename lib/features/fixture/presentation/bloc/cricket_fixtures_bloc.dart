import '../../../../core/shared/shared.dart';
import '../../domain/entities/fixtures.dart';
import '../../fixture.dart';

part 'cricket_fixtures_event.dart';
part 'cricket_fixtures_state.dart';

class CricketFixturesBloc
    extends Bloc<CricketFixturesEvent, CricketFixturesState> {
  final FixturesUseCase useCase;

  CricketFixturesBloc({
    required this.useCase,
  }) : super(const CricketFixturesInitial()) {
    on<CricketFetchFixtures>((event, emit) async {
      emit(const CricketFixturesLoading());
      final result = await useCase(type: null);
      result.fold(
        (failure) => emit(CricketFixturesError(failure: failure)),
        (fixtures) => emit(CricketFixturesDone(fixtures: fixtures)),
      );
    });
  }
}
