import '../../../../core/shared/shared.dart';

abstract class PredictionRepository {
  Future<Either<Failure, List<PredictionsEntity>>> get predictions;
  Future<Either<Failure, PredictionEntity>> fetch({
    required String fixtureGuid,
  });
    Future<Either<Failure, PredictionsEntity>> findById({
    required String fixtureGuid,
  });
}
