part of 'find_prediction_by_id_bloc.dart';


abstract class FindPredictionByIdState extends Equatable {

  const FindPredictionByIdState();

  @override
  List<Object> get props => [];
}

final class FindPredictionByIdInitial extends FindPredictionByIdState {}

final class FindPredictionByIdLoading extends FindPredictionByIdState {

  const FindPredictionByIdLoading();
}

final class FindPredictionByIdDone extends FindPredictionByIdState {  
  final PredictionsEntity prediction;
  const FindPredictionByIdDone({required this.prediction});
}

final class FindPredictionByIdError extends FindPredictionByIdState {
  final Failure message;
  const FindPredictionByIdError({required this.message});
}
