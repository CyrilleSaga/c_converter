import 'package:c_converter/services/api.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  Rx<Currency> selectedCurrency = Rx(Currency(code: "USD", name: "US Dollar"));

  void updateCurrency(Currency currency) {
    selectedCurrency.value = currency;
    update();
  }
}
