part of services;

class DefaultApi {
  final ApiClient apiClient;

  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? ApiClient();

  /// Get all supported currencies
  Future<List<Currency>> getCurrencies() async {
    Response response = await apiClient.invokeApi(
      method: "GET",
      url: "/codes",
    );

    // Map<String, dynamic> data = jsonDecode(response.data);

    List<dynamic> supportedCodes = response.data['supported_codes'];

    List<Currency> currencies = [];

    for (var element in supportedCodes) {
      currencies.add(Currency(
        code: element[0],
        name: element[1],
      ));
    }

    return currencies;
  }

  /// Get conversion rate
  Future<ConverterResponse> getConversionRate({
    required String fromCode,
    required String toCode,
    required double amount,
  }) async {
    Response response = await apiClient.invokeApi(
      method: "GET",
      url: "/pair/$fromCode/$toCode/$amount",
    );

    return ConverterResponse.fromMap(response.data);
  }
}
