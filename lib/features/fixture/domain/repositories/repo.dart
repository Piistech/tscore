import 'package:tscore/features/fixture/domain/entities/fixtures.dart';

import '../../../../core/shared/shared.dart';

abstract class FixtureRepository {
  Future<Either<Failure, List<FixturesEntity>>> get fixtures;

  Either<Failure, FixturesEntity> findById({
    required String guid,
  });
}
