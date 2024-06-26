import '../../../../core/shared/shared.dart';
import '../../analysis.dart';

class AnalysisRemoteDataSourceImpl extends AnalysisRemoteDataSource {
  final Client client;

  AnalysisRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<AnalysisModel> fetch({
    required String fixtureGuid,
  }) async {
    //! initialize headers
    final Map<String, String> headers = {
      "fixtureId": fixtureGuid,
    };

    //! initialize response
    final Response response = await client.get(
      RemoteEndpoints.analysis,
      headers: headers,
    );

    //! mock response
    // final Response response = Response(
    //   await rootBundle.loadString('mock/analysis.json'),
    //   HttpStatus.ok,
    // );

    final RemoteResponse<List<dynamic>> result = RemoteResponse.parse(
      response: response,
    );

    if (result.success) {
      final AnalysisModel analysis = AnalysisModel.parseV2(
        maps: List<Map<String, dynamic>>.from(result.result!),
      );

      return analysis;
    } else {
      throw RemoteFailure(message: result.error!);
    }
  }
}
