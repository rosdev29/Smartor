part of 'premium_cubit.dart';

class PremiumState extends Equatable {
  final bool isVip;
  final DateTime? expiryDate;
  final String? productId;
  final ProductDetails? weeklyPlan;
  final ProductDetails? monthlyPlan;
  final ProductDetails? yearlyPlan;
  final bool isTrialPeriod;
  final bool isLoading;
  final bool isRestore;
  final int indexSelected;
  final bool isBuying;
  final bool isShowAd;

  const PremiumState({
    required this.isLoading,
    this.weeklyPlan,
    this.monthlyPlan,
    this.yearlyPlan,
    this.isTrialPeriod = false,
    this.isVip = false,
    this.isRestore = false,
    this.expiryDate,
    this.productId,
    this.indexSelected = 1,
    this.isBuying = false,
    this.isShowAd = false,
  });

  PremiumState copy({
    ProductDetails? weeklyPlan,
    ProductDetails? monthlyPlan,
    ProductDetails? yearlyPlan,
    bool? isLoading,
    bool? isTrialPeriod,
    bool? isVip,
    bool? isRestore,
    DateTime? expiryDate,
    int? indexSelected,
    String? productId,
    bool? isBuying,
    bool? isShowAd,
  }) =>
      PremiumState(
        isVip: isVip ?? this.isVip,
        expiryDate: expiryDate ?? this.expiryDate,
        weeklyPlan: weeklyPlan ?? this.weeklyPlan,
        monthlyPlan: monthlyPlan ?? this.monthlyPlan,
        yearlyPlan: yearlyPlan ?? this.yearlyPlan,
        isTrialPeriod: isTrialPeriod ?? this.isTrialPeriod,
        isLoading: isLoading ?? this.isLoading,
        isRestore: isRestore ?? this.isRestore,
        productId: productId ?? this.productId,
        indexSelected: indexSelected ?? this.indexSelected,
        isBuying: isBuying ?? this.isBuying,
        isShowAd: isShowAd ?? this.isShowAd,
      );

  @override
  List<Object?> get props => [
        isVip,
        expiryDate,
        weeklyPlan,
        monthlyPlan,
        yearlyPlan,
        isTrialPeriod,
        isLoading,
        isRestore,
        indexSelected,
        productId,
        isBuying,
        isShowAd,
      ];
}
