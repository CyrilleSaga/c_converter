part of services;

class DefaultApi {
  final ApiClient apiClient;

  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? ApiClient();

  /// Get all supported currencies
  Future<List<Currency>> getCurrencies() async {
    Response response = await apiClient.invokeApi(
      method: "GET",
      body: null,
      url: "/codes",
    );

    Map<String, dynamic> data = jsonDecode(response.data);

    List<List<String>> supportedCodes = data['supported_codes'];

    List<Currency> currencies = [];

    for (var element in supportedCodes) {
      currencies.add(Currency(
        code: element[0],
        name: element[1],
      ));
    }

    log("Currencies: $currencies");

    return currencies;
  }
}
