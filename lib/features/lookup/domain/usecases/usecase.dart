
import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class LookupUsecase {
  final LookupRepository repository;
  LookupUsecase({
    required this.repository,
  });
  Future<Either<Failure, List<LookupEntity>>> call({
    required String key,
  }) async {
    return await repository.fetch(
      key: key,
    );
  }
}
