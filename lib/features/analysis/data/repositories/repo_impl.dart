import '../../../../core/shared/shared.dart';
import '../../analysis.dart';

class AnalysisRepositoryImpl implements AnalysisRepository {
  final NetworkInfo network;
  final AnalysisRemoteDataSource remote;

  AnalysisRepositoryImpl({
    required this.network,
    required this.remote,
  });

  @override
  Future<Either<Failure, AnalysisEntity>> fetch({
    required String fixtureGuid,
  }) async {
    try {
      final AnalysisModel analysis =
          await remote.fetch(fixtureGuid: fixtureGuid);

      return Right(analysis);
    } on AnalysisNotFoundFailure {
      if (await network.online) {
        try {
          final AnalysisModel analysis =
              await remote.fetch(fixtureGuid: fixtureGuid);

          return Right(analysis);
        } on Failure catch (e) {
          return Left(e);
        }
      } else {
        return Left(NoInternetFailure());
      }
    }
  }
}
