import '../../../../core/shared/shared.dart';
import '../../analysis.dart';

abstract class AnalysisRepository {
  Future<Either<Failure, AnalysisEntity>> fetch({
    required String fixtureGuid,
  });
}
