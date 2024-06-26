import '../../../../core/shared/shared.dart';

class PredictionsUsecase {
  final PredictionRepository repository;
  PredictionsUsecase({
    required this.repository,
  });
  Future<Either<Failure, List<PredictionsEntity>>> call() async {
    return await repository.predictions;
  }
}
