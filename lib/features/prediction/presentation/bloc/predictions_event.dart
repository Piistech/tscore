part of 'predictions_bloc.dart';


abstract class PredictionsEvent extends Equatable {
  const PredictionsEvent();
  @override
  List<Object> get props => [];
}

class Fetch extends PredictionsEvent {
   const Fetch();
  @override
  List<Object> get props => [];
}
