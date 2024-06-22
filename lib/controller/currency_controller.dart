import 'package:c_converter/services/api.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  final Currency initialCurrency;

  CurrencyController({required this.initialCurrency}) {
    updateCurrency(initialCurrency);
  }

  Rx<Currency?> selectedCurrency = Rx(null);

  void updateCurrency(Currency currency) {
    selectedCurrency.value = currency;
    update();
  }
}
