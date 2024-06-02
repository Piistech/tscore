class RemoteEndpoints {
  static const String _baseUrl = 'https://tscore-api.made-in-bd.com/v1';

  static Uri get fixtures => Uri.parse('$_baseUrl/get-fixture-home');

  static Uri get prediction => Uri.parse('$_baseUrl/get-prediction');
  static Uri get predictionById => Uri.parse('$_baseUrl/get-prediction-fixId');
  
  static Uri get predictions => Uri.parse('$_baseUrl/get-fixture-prediction');
  
  static Uri get analysis => Uri.parse('$_baseUrl/get-analysis');

  static Uri get commentary => Uri.parse('$_baseUrl/get-commentary');
  static Uri get lookup => Uri.parse('$_baseUrl/get-lookup-by-key');

  static Uri get team => Uri.parse('$_baseUrl/get-team');
}
