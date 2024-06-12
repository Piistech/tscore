import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tscore/core/shared/error/failure/failure.dart';
import 'package:tscore/features/fixture/domain/entities/fixtures.dart';
import 'package:tscore/features/fixture/domain/usecases/fixtures.dart';

part 'football_fixtures_event.dart';
part 'football_fixtures_state.dart';

class FootballFixturesBloc
    extends Bloc<FootballFixturesEvent, FootballFixturesState> {
  final FixturesUseCase useCase;

  FootballFixturesBloc({
    required this.useCase,
  }) : super(FootballFixturesInitial()) {
    on<FootballFixturesEvent>((event, emit) async {
      emit(const FootballFixturesLoading());
      final result = await useCase();
      result.fold(
        (failure) => emit(FootballFixturesError(failure: failure)),
        (fixtures) => emit(FootballFixturesDone(fixtures: fixtures)),
      );
    });
  }
}
