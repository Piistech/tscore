import 'package:tscore/features/fixture/domain/entities/fixtures.dart';

import '../../../../core/shared/shared.dart';
import '../../fixture.dart';

class FixturesUseCase {
  final FixtureRepository repository;

  FixturesUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<FixturesEntity>>> call() async {
    return await repository.fixtures;
  }
}
