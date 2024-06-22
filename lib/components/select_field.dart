import 'package:c_converter/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/currency_controller.dart';
import '../helpers/constants.dart';

class SelectField extends StatelessWidget {
  final List<Currency> currencies;
  final Function(Currency) onCurrencySelected;
  final CurrencyController controller;

  const SelectField({
    super.key,
    this.currencies = const [],
    required this.onCurrencySelected,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showBottomSheet(
        context: context,
        builder: (context) {
          return cbottomSheet(context: context);
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: AppConstants.defaultPadding * .4),
            Obx(
              () => Text(
                "${controller.selectedCurrency.value?.name} (${controller.selectedCurrency.value?.code})",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontFamily: AppConstants.fontFamily,
                      color: AppColors.primaryColor,
                    ),
              ),
            ),
            const SizedBox(width: AppConstants.defaultPadding * .5),
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget cbottomSheet({
    required BuildContext context,
  }) {
    return Container(
      height: Get.height * 0.75,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.defaultPadding),
          Center(
            child: Container(
              height: 5,
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                color: AppColors.textMutedColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding * 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
            child: Text(
              "Select Currency",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 25,
                    fontFamily: AppConstants.fontFamily,
                  ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Divider(
            color: AppColors.textMutedColor.withOpacity(0.5),
            height: 1,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    currencies[index].name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: AppConstants.fontFamily,
                          color: AppColors.textMutedColor,
                        ),
                  ),
                  subtitle: Text(
                    currencies[index].code,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: AppConstants.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  trailing: GetBuilder<CurrencyController>(
                      init: controller,
                      builder: (ctrl) {
                        if (ctrl.selectedCurrency.value?.code == currencies[index].code) {
                          return const Icon(
                            CupertinoIcons.checkmark_alt_circle_fill,
                            color: AppColors.primaryColor,
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                  onTap: () {
                    onCurrencySelected(currencies[index]);
                    controller.updateCurrency(currencies[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
