import '../../../../core/shared/shared.dart';

class PredictionUseCase {
  final PredictionRepository repository;
  PredictionUseCase({
    required this.repository,
  });
  Future<Either<Failure, PredictionEntity>> call({
    required String fixtureGuid,
  }) async {
    return await repository.fetch(fixtureGuid: fixtureGuid);
  }
}
