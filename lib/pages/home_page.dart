import 'package:c_converter/components/c_input_field.dart';
import 'package:c_converter/components/select_field.dart';
import 'package:c_converter/controller/currency_controller.dart';
import 'package:c_converter/helpers/constants.dart';
import 'package:c_converter/services/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SelectField(
                    currencies: [
                      Currency(code: "USD", name: "US Dollar"),
                      Currency(code: "EUR", name: "Euro"),
                    ],
                    onCurrencySelected: (v) {},
                    controller: CurrencyController(),
                  ),
                  const CInputField(),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.defaultPadding * 2),

            // Swicth Currencies
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SelectField(
                    currencies: [
                      Currency(code: "USD", name: "US Dollar"),
                      Currency(code: "EUR", name: "Euro"),
                    ],
                    onCurrencySelected: (v) {},
                    controller: CurrencyController(),
                  ),
                  const CInputField(),
                ],
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
