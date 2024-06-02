
import '../../../../../core/shared/shared.dart';

part 'find_prediction_by_id_event.dart';
part 'find_prediction_by_id_state.dart';

class FindPredictionByIdBloc extends Bloc<FindPredictionByIdEvent, FindPredictionByIdState> {
  final FindPredictionByIdUseCase useCase;
  FindPredictionByIdBloc({
    required this.useCase,
  }) : super(FindPredictionByIdInitial()) {
    on<FindPredictionById>((event, emit) async {
      emit(const FindPredictionByIdLoading());
      final result = await useCase(
        guid: event.guid,
      );
      result.fold(
        (failure) => emit(FindPredictionByIdError(message: failure)),
        (prediction) => emit(FindPredictionByIdDone(prediction: prediction)),
      );
    });
  }
}
