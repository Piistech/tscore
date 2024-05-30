

import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class LookupRepositoryImpl extends LookupRepository {
  final NetworkInfo network;
  final LookupRemoteDataSource remote;

  LookupRepositoryImpl({
    required this.remote,
    required this.network,
  });

  @override
  Future<Either<Failure, List<LookupEntity>>> fetch({required String key}) async {
    if (await network.online) {
      try {
        final List<Lookup> lookups = await remote.fetch(key: key);

        return Right(lookups);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
