import '../../../../core/shared/shared.dart';

class PredictionModel extends PredictionEntity {
  PredictionModel({
    required super.winnerTeamId,
    required super.winnerTeamIdAfterToss,
  });

  factory PredictionModel.parse(Map<String, dynamic> map) {
    try {


      return PredictionModel(
        winnerTeamId: map['predictionwinnerId'],
        winnerTeamIdAfterToss: map['predictionwinnerAfterId'],
      );
    } catch (e, stackTrace) {
      throw PredictionModelParsingFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

}
