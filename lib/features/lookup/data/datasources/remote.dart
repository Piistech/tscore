
import '../../lookup.dart';

abstract class LookupRemoteDataSource {
  Future<List<Lookup>> fetch({
    required String key,
  });
}