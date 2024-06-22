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
            padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 2),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "C Converter",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 25,
                            color: AppColors.primaryColor,
                            fontFamily: AppConstants.fontFamily,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    Text(
                      "Currency",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            fontFamily: AppConstants.fontFamily,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              Divider(
                color: AppColors.textMutedColor.withOpacity(0.5),
                height: 1,
              ),
              const SizedBox(height: AppConstants.defaultPadding * 1.5),

              // Currency I have
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CURRENCY I HAVE",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                          ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding * 0.25),
                    Text(
                      "I have this much to exchange",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontFamily: AppConstants.fontFamily,
                            color: AppColors.textMutedColor,
                          ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * .5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                child: Divider(
                  color: AppColors.textMutedColor.withOpacity(0.5),
                  height: 1,
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding * .5),

              // Input field
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BlocBuilder<HandleCurrencyBloc, HandleCurrencyState>(
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
                                amount: amountFromController.text.isNotEmpty ? double.parse(amountFromController.text) : 1,
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
              ),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              // Swicth Currencies
              GestureDetector(
                onTap: () {
                  _handleCurrencyBloc.add(SwicthCurrenciesEvent(
                    fromCode: selectedFromCurrency.value.code,
                    toCode: selectedToCurrency.value.code,
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.swap_vert,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                      const SizedBox(width: AppConstants.defaultPadding),
                      Text(
                        'Switch Currencies',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: AppConstants.fontFamily,
                              color: AppColors.primaryColor,
                            ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              // Currency I want
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CURRENCY I WANT",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                          ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding * 0.25),
                    Text(
                      "I want to buy something at this price",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontFamily: AppConstants.fontFamily,
                            color: AppColors.textMutedColor,
                          ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * .5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                child: Divider(
                  color: AppColors.textMutedColor.withOpacity(0.5),
                  height: 1,
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding * .5),

              // Input field
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BlocBuilder<HandleCurrencyBloc, HandleCurrencyState>(
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
                                amount: amountToController.text.isNotEmpty ? double.parse(amountToController.text) : 1,
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
              ),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              Divider(
                color: AppColors.textMutedColor.withOpacity(0.5),
                height: 1,
              ),
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
