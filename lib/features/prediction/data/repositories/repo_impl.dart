
import '../../../../core/shared/shared.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  final NetworkInfo network;
  final PredictionRemoteDataSource remote;

  const PredictionRepositoryImpl({
    required this.network,
    required this.remote,
  });
  @override
  Future<Either<Failure, List<PredictionsEntity>>> get predictions async {
    if (await network.online) {
      try {
        final List<PredictionsModel> predictions = await remote.predictions;

        return Right(predictions);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, PredictionEntity>> fetch({
    required String fixtureGuid,
  }) async {
    if (await network.online) {
      try {
        final PredictionModel prediction = await remote.fetch(fixtureGuid: fixtureGuid);
        return Right(prediction);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, PredictionsEntity>> findById({
    required String fixtureGuid,
  }) async {
    if (await network.online) {
      try {
        final PredictionsModel prediction = await remote.findById(fixtureGuid: fixtureGuid);
        return Right(prediction);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
