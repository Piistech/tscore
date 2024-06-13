import '../../fixture.dart';

abstract class FixtureRemoteDataSource {
  Future<List<FixtureModel>> fixtures({
    required String? type,
  });
}
