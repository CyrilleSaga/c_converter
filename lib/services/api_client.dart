part of services;

class ApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = AppConstants.apiUrl});

  final client = Dio();

  Future<Response> invokeApi({
    String? method,
    Map<String, dynamic>? params,
    Object? body,
    required String url,
  }) async {
    return await client.request(
      url,
      data: jsonEncode(body),
      options: Options(
        method: method,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${AppConstants.apiKey}",
        },
      ),
    );
  }
}
