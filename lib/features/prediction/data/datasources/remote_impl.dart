
import '../../../../core/shared/shared.dart';

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

    final RemoteResponse<Map<String, dynamic>> result = RemoteResponse.parse(response: response);

    if (result.success) {
      //final PredictionModel prediction = PredictionModel.parse(result.result!);

      final PredictionModel prediction = PredictionModel.parse(result.result!);
      return prediction;
    } else {
      throw RemoteFailure(message: result.error!);
    }
  }

  @override
  Future<List<PredictionsModel>> get predictions async {
    //! initialize response
    final Response response = await client.get(
      RemoteEndpoints.predictions,
    );

    final RemoteResponse<List<dynamic>> result = RemoteResponse.parse(
      response: response,
    );

    if (result.success) {
      final List<PredictionsModel?> predictions = result.result!.map(
        (map) {
          try {
            return PredictionsModel.parse(
              map: Map<String, dynamic>.from(map),
            );
          } catch (e) {
            return null;
          }
        },
      ).toList();
      return predictions.whereType<PredictionsModel>().toList();
    } else {
      throw RemoteFailure(message: result.error!);
    }
  }

  @override
  Future<PredictionsModel> findById({
    required String fixtureGuid,
  }) async {
    //! initialize headers
    // final Map<String, String> headers = {};
    final Map<String, String> headers = {
      "fixtureId": fixtureGuid,
    };
    //! initialize response
    final Response response = await client.get(
      RemoteEndpoints.predictionById,
      headers: headers,
    );

    final RemoteResponse<Map<String, dynamic>> result = RemoteResponse.parse(response: response);

    if (result.success) {
      //final PredictionModel prediction = PredictionModel.parse(result.result!);

      final PredictionsModel prediction = PredictionsModel.parse(map: result.result!);
      return prediction;
    } else {
      throw RemoteFailure(message: result.error!);
    }
  }
}
