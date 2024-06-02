
import '../../prediction.dart';

abstract class PredictionRemoteDataSource {
  Future<PredictionModel> fetch ({
    required String fixtureGuid,
  });

  Future<List<PredictionsModel>> get predictions;

    Future<PredictionsModel> findById ({
    required String fixtureGuid,
  });
}
