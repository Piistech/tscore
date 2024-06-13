import '../../../../core/shared/shared.dart';
import '../../domain/entities/fixtures.dart';
import '../../fixture.dart';

class FixtureRepositoryImpl extends FixtureRepository {
  final NetworkInfo network;
  final FixtureRemoteDataSource remote;
  final FixtureLocalDataSource local;

  FixtureRepositoryImpl({
    required this.network,
    required this.remote,
    required this.local,
  });

  @override
  Future<Either<Failure, List<FixturesEntity>>> fixtures({
    required String? type,
  }) async {
    if (await network.online) {
      try {
        final List<FixtureModel> fixtures = await remote.fixtures(type: type);
        local.cache(fixtures: fixtures);
        return Right(fixtures);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Either<Failure, FixturesEntity> findById({
    required String guid,
  }) {
    try {
      final FixtureModel fixture = local.findById(guid: guid);
      return Right(fixture);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
