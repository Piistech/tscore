import '../../../../core/shared/shared.dart';
import '../../prediction.dart';

class PredictionDataSourceImpl extends PredictionRemoteDataSource {
  final Client client;

  PredictionDataSourceImpl({
    required this.client,
  });

  @override
  Future<PredictionModel> fetch({
    required String fixtureGuid,
  }) async {
    //! initialize headers
    // final Map<String, String> headers = {};
    final Map<String, String> headers = {
      "fixtureId": fixtureGuid,
    };
    //! initialize response
    final Response response = await client.get(
      RemoteEndpoints.prediction,
      headers: headers,
    );

    //! initialize result

    final Map<String, dynamic> map = Map<String, dynamic>.from(
      json.decode(response.body),
    );
    if (map["success"]) {
      final RemoteResponse<Map<String, dynamic>> result = RemoteResponse.parse(response: response);

      if (result.success) {
        //final PredictionModel prediction = PredictionModel.parse(result.result!);

        final PredictionModel prediction = PredictionModel.parse(result.result!);
        return prediction;
      } else {
        throw RemoteFailure(message: result.error!);
      }
    } else {
      throw RemoteFailure(message: map["error"]);
    }
  }
}
