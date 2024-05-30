

import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

part 'lookup_event.dart';
part 'lookup_state.dart';

class LookupBloc extends Bloc<LookupEvent, LookupState> {
  final LookupUsecase usecase;
  LookupBloc({required this.usecase}) : super(LookupInitial()) {
    on<FetchLookup>((event, emit) async {
      emit(const LookupLoading());
      final result = await usecase(
        key: event.key,
      );
      result.fold(
        (failure) => emit(LookupError(failure: failure)),
        (lookups) => emit(LookupDone(lookups: lookups)),
      );
    });
  }
}
