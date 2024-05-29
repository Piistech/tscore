import '../../../../core/shared/shared.dart';
import '../../../fixture/fixture.dart';

abstract class PredictionRepository {
  Future<Either<Failure, List<PredictionsEntity>>> get predictions;
  Future<Either<Failure, PredictionEntity>> fetch({
    required String fixtureGuid,
  });
}
