import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class LookupRemoteDataSourceImpl implements LookupRemoteDataSource {
  final Client client;

  LookupRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Lookup>> fetch({
    required String key,
  }) async {
    try {
      //! initialize headers
      final Map<String, String> headers = {
        'key': key,
      };

      //! initialize response
      final Response response = await client.get(
        RemoteEndpoints.lookup,
        headers: headers,
      );

      final RemoteResponse<List<dynamic>> result = RemoteResponse.parse(
        response: response,
      );
      if (result.success) {
        
      final List<Lookup?> lookups = result.result!.map(
        (map) {
          try {
            return Lookup.parse(
              map: Map<String, dynamic>.from(map),
            );
          } catch (e) {
            return null;
          }
        },
      ).toList();

        return lookups.whereType<Lookup>().toList();
      } else {
        throw RemoteFailure(message: result.error!);
      }
    } catch (e) {
      rethrow;
    }
  }
}
