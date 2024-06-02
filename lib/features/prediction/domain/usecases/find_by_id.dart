import '../../../../core/shared/shared.dart';

class FindPredictionByIdUseCase {
  final PredictionRepository repository;

  FindPredictionByIdUseCase({
    required this.repository,
  });

  Future<Either<Failure, PredictionsEntity>> call({
    required String guid,
  }) {
    return repository.findById(fixtureGuid: guid);
  }
}
