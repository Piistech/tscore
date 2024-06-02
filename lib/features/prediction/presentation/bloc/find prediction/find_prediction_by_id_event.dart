part of 'find_prediction_by_id_bloc.dart';

abstract class FindPredictionByIdEvent extends Equatable {
  const FindPredictionByIdEvent();
}

class FindPredictionById extends FindPredictionByIdEvent {
  final String guid;
  const FindPredictionById({required this.guid});

  @override
  List<Object> get props => [guid];
}
