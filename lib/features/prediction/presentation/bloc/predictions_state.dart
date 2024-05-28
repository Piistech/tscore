part of 'predictions_bloc.dart';

abstract class PredictionsState {
  const PredictionsState();
}

final class PredictionsInitial extends PredictionsState {
  const PredictionsInitial();
}

final class PredictionsLoading extends PredictionsState {
  const PredictionsLoading();
}

final class PredictionsDone extends PredictionsState {
  final List<PredictionsEntity> fixtures;
  PredictionsDone({required this.fixtures});
}

final class PredictionsError extends PredictionsState {
  final Failure failure;
  PredictionsError({required this.failure});
}
