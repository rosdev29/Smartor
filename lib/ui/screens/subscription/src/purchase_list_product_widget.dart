part of '../core.dart';

class _PurchaseListProductWidget extends StatelessWidget {
  const _PurchaseListProductWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PremiumCubit>().state;
    final trialFree = state.isTrialPeriod && state.indexSelected == 1;
    final textBtn =
        trialFree ? S.current.startTrial : S.current.subscription_button;
    final products = [state.weeklyPlan, state.monthlyPlan, state.yearlyPlan];
    final prd = products[state.indexSelected];
    final textHint = trialFree
        ? '${S.current.try_free2} ${prd?.price} ${S.current.try_free1}'
        : '${S.current.try_free} ${prd?.price} ${S.current.try_free1}';

    final textHintIOS = trialFree
        ? '${S.current.label_3_day_free} ${prd?.price}${S.current.label_3_day_free_month}'
        : '';

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
                childAspectRatio: 1),
            itemBuilder: (context, index) => ProductItemWidget(
                  hasTrial: trialFree,
                  productDetails: products[index]!,
                  isSelected: state.indexSelected == index,
                  onTap: () => context.read<PremiumCubit>().selectedPlan(index),
                )),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            textHintIOS,
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        _ElevatedButtonWidget(
            onPressed: () => context
                .read<PremiumCubit>()
                .buyPremium(productDetails: products[state.indexSelected]!),
            title: textBtn),
        TextButton(
            onPressed: () => context.read<PremiumCubit>().restorePremium(),
            child: Text(
              S.current.restore,
              style: context.textTheme.labelSmall!.copyWith(
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            )),
        const SizedBox(height: 32),
        Platform.isAndroid
            ? Text(
                textHint,
                style: context.textTheme.labelSmall,
                textAlign: TextAlign.center,
              )
            : const SizedBox(),
      ],
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget(
      {super.key,
      required this.productDetails,
      required this.hasTrial,
      required this.onTap,
      required this.isSelected});

  final ProductDetails productDetails;
  final void Function() onTap;
  final bool isSelected;
  final bool hasTrial;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = context.textTheme.labelSmall!.copyWith(
      color: isSelected ? Colors.white : Colors.grey,
    );
    final bodySmall = context.textTheme.bodySmall!.copyWith(
      color: isSelected ? Colors.white : Colors.grey.shade500,
    );
    final titleSmall = context.textTheme.titleSmall!.copyWith(
        color: isSelected ? Colors.white : Colors.grey.shade500,
        fontWeight: FontWeight.w500);
    final textTrial = productDetails.id == Constants.kMonthlyId && hasTrial
        ? S.current.trial
        : '';
    return Card(
      margin: EdgeInsets.zero,
      elevation: isSelected ? 16 : 0,
      shadowColor: isSelected ? Colors.blue : Colors.grey,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: isSelected ? Colors.blue.shade800 : Colors.grey.shade300,
                spreadRadius: 1.5,
                offset: const Offset(1.5, 1.5),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                productDetails.id.toProductName,
                style: bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                productDetails.price,
                style: titleSmall,
                textAlign: TextAlign.center,
              ),
              Text(
                textTrial,
                style: bodySmall,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
