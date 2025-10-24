import 'package:c_converter/components/c_input_field.dart';
import 'package:c_converter/components/select_field.dart';
import 'package:c_converter/controller/currency_controller.dart';
import 'package:c_converter/helpers/constants.dart';
import 'package:c_converter/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../controller/handle_converter/handle_converter_bloc.dart';
import '../controller/handle_currency/handle_currency_bloc.dart';
import '../locales/tr.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    _handleCurrencyBloc.add(FetchCurrenciesEvent());
  }

  final _handleCurrencyBloc = HandleCurrencyBloc();
  final _handleConverterBloc = HandleConverterBloc();

  final RxDouble convertionRate = RxDouble(0.0);

  final TextEditingController amountFromController = TextEditingController();
  final TextEditingController amountToController = TextEditingController();

  final Rx<Currency> selectedFromCurrency = Rx(Currency(code: "", name: ""));
  final Rx<Currency> selectedToCurrency = Rx(Currency(code: "", name: ""));

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HandleCurrencyBloc, HandleCurrencyState>(
          bloc: _handleCurrencyBloc,
          listener: (context, state) {
            if (state is HandleCurrencyLoaded) {
              selectedFromCurrency.value = state.selectedFromCurrency;
              selectedToCurrency.value = state.selectedToCurrency;
              _handleConverterBloc.add(GetConversionRateEvent(
                fromCode: state.selectedFromCurrency.code,
                toCode: state.selectedToCurrency.code,
                amount: 1,
              ));
            }
          },
        ),
        BlocListener<HandleConverterBloc, HandleConverterState>(
          bloc: _handleConverterBloc,
          listener: (context, state) {
            if (state is HandleConverterLoaded) {
              convertionRate.value = state.conversionResponse.conversionRate;
              convertAmountFromToAmountTo(amountToController.text);
              convertAmountToFromAmountFrom(amountFromController.text);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Hero Section with Gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding * 2,
                    vertical: AppConstants.defaultPadding * 3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr(context).welcome,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                              fontFamily: AppConstants.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding * 0.5),
                      Text(
                        "C Converter",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 36,
                              color: Colors.white,
                              fontFamily: AppConstants.fontFamily,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      Text(
                        tr(context).appDescription,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.95),
                              fontFamily: AppConstants.fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              // Conversion Rate Card
              Obx(() => convertionRate.value > 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding * 2,
                      ),
                      padding: const EdgeInsets.all(AppConstants.defaultPadding * 1.5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryColor.withOpacity(0.1),
                            AppColors.primaryColor.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.trending_up,
                              color: AppColors.primaryColor,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: AppConstants.defaultPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr(context).conversionRate,
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        fontFamily: AppConstants.fontFamily,
                                        color: AppColors.textMutedColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "1 ${selectedFromCurrency.value.code} = ${convertionRate.value.toStringAsFixed(4)} ${selectedToCurrency.value.code}",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        fontFamily: AppConstants.fontFamily,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink()),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              // Currency I have Section
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding * 2,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: AppConstants.defaultPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr(context).currencyIHave.toUpperCase(),
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppConstants.fontFamily,
                                        letterSpacing: 0.5,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tr(context).currencyIHaveDescription,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontFamily: AppConstants.fontFamily,
                                        color: AppColors.textMutedColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.defaultPadding * 1.5),
                      Divider(
                        color: AppColors.textMutedColor.withOpacity(0.2),
                        height: 1,
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      BlocBuilder<HandleCurrencyBloc, HandleCurrencyState>(
                        bloc: _handleCurrencyBloc,
                        builder: (context, state) {
                          if (state is HandleCurrencyLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SelectField(
                                  currencies: state.currencies,
                                  onCurrencySelected: (v) {
                                    selectedFromCurrency.value = v;
                                    _handleConverterBloc.add(GetConversionRateEvent(
                                      fromCode: selectedFromCurrency.value.code,
                                      toCode: selectedToCurrency.value.code,
                                      amount: amountFromController.text.isNotEmpty
                                          ? double.parse(amountFromController.text)
                                          : 1,
                                    ));
                                  },
                                  controller: CurrencyController(
                                    initialCurrency: state.selectedFromCurrency,
                                  ),
                                ),
                                CInputField(
                                  controller: amountFromController,
                                  onChanged: (v) {
                                    convertAmountToFromAmountFrom(v);
                                  },
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              // Enhanced Switch Button
              GestureDetector(
                onTap: () {
                  _handleCurrencyBloc.add(SwicthCurrenciesEvent(
                    fromCode: selectedFromCurrency.value.code,
                    toCode: selectedToCurrency.value.code,
                  ));
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding * 2,
                      vertical: AppConstants.defaultPadding,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: AppConstants.defaultPadding),
                        Text(
                          tr(context).switchCurrencies,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontFamily: AppConstants.fontFamily,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              // Currency I want Section
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding * 2,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.currency_exchange,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: AppConstants.defaultPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr(context).currencyIWant.toUpperCase(),
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppConstants.fontFamily,
                                        letterSpacing: 0.5,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tr(context).currencyIWantDescription,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontFamily: AppConstants.fontFamily,
                                        color: AppColors.textMutedColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.defaultPadding * 1.5),
                      Divider(
                        color: AppColors.textMutedColor.withOpacity(0.2),
                        height: 1,
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      BlocBuilder<HandleCurrencyBloc, HandleCurrencyState>(
                        bloc: _handleCurrencyBloc,
                        builder: (context, state) {
                          if (state is HandleCurrencyLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SelectField(
                                  currencies: state.currencies,
                                  onCurrencySelected: (v) {
                                    selectedToCurrency.value = v;
                                    _handleConverterBloc.add(GetConversionRateEvent(
                                      fromCode: selectedFromCurrency.value.code,
                                      toCode: selectedToCurrency.value.code,
                                      amount: amountToController.text.isNotEmpty
                                          ? double.parse(amountToController.text)
                                          : 1,
                                    ));
                                  },
                                  controller: CurrencyController(
                                    initialCurrency: state.selectedToCurrency,
                                  ),
                                ),
                                CInputField(
                                  controller: amountToController,
                                  onChanged: (v) {
                                    convertAmountFromToAmountTo(v);
                                  },
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * 3),

              // Footer with info
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding * 2,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      decoration: BoxDecoration(
                        color: AppColors.textMutedColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.textMutedColor,
                            size: 16,
                          ),
                          const SizedBox(width: AppConstants.defaultPadding * 0.5),
                          Flexible(
                            child: Text(
                              "Exchange rates updated in real-time",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontFamily: AppConstants.fontFamily,
                                    color: AppColors.textMutedColor,
                                    fontSize: 12,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }

  void convertAmountToFromAmountFrom(String v) {
    if (v.isNotEmpty) {
      amountToController.text = (double.parse(v) * convertionRate.value).toStringAsFixed(3);
    } else {
      amountToController.text = "";
    }
  }

  void convertAmountFromToAmountTo(String v) {
    if (v.isNotEmpty) {
      amountFromController.text = (double.parse(v) / convertionRate.value).toStringAsFixed(3);
    } else {
      amountFromController.text = "";
    }
  }
}
