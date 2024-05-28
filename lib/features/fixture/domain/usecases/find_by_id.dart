import '../../../../core/shared/shared.dart';
import '../../fixture.dart';
import '../entities/fixtures.dart';

class FindFixtureByIdUseCase {
  final FixtureRepository repository;

  FindFixtureByIdUseCase({
    required this.repository,
  });

  Either<Failure, FixturesEntity> call({
    required String guid,
  }) {
    return repository.findById(guid: guid);
  }
}
