import 'package:tscore/features/prediction/data/models/prediction_list_model.dart';

import '../models/prediction.dart';

abstract class PredictionRemoteDataSource {
  Future<PredictionModel> fetch ({
    required String fixtureGuid,
  });

  Future<List<PredictionsModel>> get predictions;
}
