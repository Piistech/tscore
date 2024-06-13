// import 'dart:developer';

import '../../../../core/shared/shared.dart';

part 'predictions_event.dart';
part 'predictions_state.dart';

class PredictionsBloc extends Bloc<PredictionsEvent, PredictionsState> {
  final PredictionsUsecase useCase;
  PredictionsBloc({required this.useCase}) : super(const PredictionsInitial()) {
    on<Fetch>((event, emit) async {
      emit(const PredictionsLoading());
      final result = await useCase();
      result.fold(
        (failure) => emit(PredictionsError(failure: failure)),
        (predictions) {
          List<PredictionsEntity> sortedPredictions =
              List<PredictionsEntity>.from(predictions);
          sortedPredictions.sort((a, b) {
            // log('${a.startedAt} ${b.startedAt}');
            return b.startedAt.compareTo(a.startedAt);
          });

          emit(PredictionsDone(fixtures: sortedPredictions));
        },
      );
    });
  }
}
