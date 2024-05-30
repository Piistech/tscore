


import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

abstract class LookupRepository {
  Future<Either<Failure, List<LookupEntity>>> fetch({
    required String key
  });
}
