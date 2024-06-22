import 'package:c_converter/components/c_input_field.dart';
import 'package:c_converter/components/select_field.dart';
import 'package:c_converter/controller/currency_controller.dart';
import 'package:c_converter/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/bloc/handle_currency_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    _handleCurrencyBloc.add(FetchCurrenciesEvent());
  }

  final _handleCurrencyBloc = HandleCurrencyBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onCurrencySelected: (v) {},
                          controller: CurrencyController(
                            initialCurrency: state.selectedFromCurrency,
                          ),
                        ),
                        const CInputField(),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            const SizedBox(height: AppConstants.defaultPadding * 2),

            // Swicth Currencies
            Padding(
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
                          onCurrencySelected: (v) {},
                          controller: CurrencyController(
                            initialCurrency: state.selectedToCurrency,
                          ),
                        ),
                        const CInputField(),
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
    );
  }
}
