import 'dart:convert';

import 'package:http/http.dart';

class RemoteResponse<T> {
  final bool success;
  final String? error;
  final T? result;

  RemoteResponse({
    required this.success,
    required this.error,
    required this.result,
  });

  factory RemoteResponse.parse({
    required Response response,
  }) {
    final Map<String, dynamic> payload = json.decode(response.body);

    final bool success = payload['success'] as bool;
    //print(result);

    if (success) {
      final T? result = payload['result'] as T?;
      return RemoteResponse._success(result: result);
    } else {
      final String? error = payload['error'] as String?;
      assert(
        error != null,
        'Error message is required',
      );
      return RemoteResponse._error(error: error!);
    }
  }

  factory RemoteResponse._error({
    required String error,
  }) {
    return RemoteResponse<T>(
      success: false,
      error: error,
      result: null,
    );
  }

  factory RemoteResponse._success({
    required T? result,
  }) {
    return RemoteResponse<T>(
      success: true,
      error: null,
      result: result,
    );
  }
}
