import 'dart:async';

import 'package:calc_pro/core/constants/constants.dart';
import 'package:calc_pro/core/extensions/purchase_details_extension.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/data/models/subscription.dart';
import 'package:calc_pro/data/usecase/check_exp_vip_use_case.dart';
import 'package:calc_pro/data/usecase/check_show_ad_use_case.dart';
import 'package:calc_pro/data/usecase/update_exp_vip_use_case.dart';
import 'package:calc_pro/ui/routers/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iap_quick/iap_quick.dart';

part 'premium_state.dart';

class PremiumCubit extends Cubit<PremiumState> {
  PremiumCubit({
    required UpdateExpVipUseCase updateExpVipUseCase,
    required CheckExpVipUseCase checkExpVipUseCase,
    required CheckShowAdUseCase checkShowAdUseCase,
  })  : _checkExpVipUseCase = checkExpVipUseCase,
        _updateExpVipUseCase = updateExpVipUseCase,
        _checkShowAdUseCase = checkShowAdUseCase,
        super(const PremiumState(isLoading: true));

  final CheckShowAdUseCase _checkShowAdUseCase;
  final UpdateExpVipUseCase _updateExpVipUseCase;
  final CheckExpVipUseCase _checkExpVipUseCase;
  final _iap = IAPQuick();

  ///Thực hiện kiểm tra gói đăng ký hiện tại của người dùng
  ///Tham số onlyCheckUser == true, khi đó chỉ lấy dữ liệu của người
  ///dùng từ sharedpreferences, nếu bằng false nó sẽ gọi đến của hàng
  ///để lấy thông tin và nếu có sẽ cập nhật lại dữ liệu
  FutureOr<void> checkVip(bool onlyCheckUser) async {
    if (state.isVip) return;
    final subscription = await _checkExpVipUseCase.call();
    final isVip = subscription?.isVip ?? false;
    if (isVip) {
      emit(PremiumState(
        isLoading: false,
        isVip: isVip,
        expiryDate: subscription!.expiryDate,
        productId: subscription.productId,
        isShowAd: false,
      ));
      return;
    } else {
      final isShowAd = await _checkShowAdUseCase.call();
      if (isShowAd != state.isShowAd) {
        emit(state.copy(isShowAd: isShowAd));
      }
    }
    if (onlyCheckUser) return;
    final available = await _iap.isAvailable();
    if (!available) return;
    final response = await _iap.queryProductDetails(
        {Constants.kWeeklyId, Constants.kMonthlyId, Constants.kYearlyId});
    if (response.notFoundIDs.isNotEmpty) return;
    final isTrialPeriod = response.productDetails.any((e) => e.hasTrialPeriod);
    final weeklyPlan =
        response.productDetails.firstWhere((e) => e.id == Constants.kWeeklyId);
    final monthlyPlan =
        response.productDetails.firstWhere((e) => e.id == Constants.kMonthlyId);
    final yearlyPlan =
        response.productDetails.firstWhere((e) => e.id == Constants.kYearlyId);
    emit(state.copy(
      isTrialPeriod: isTrialPeriod,
      weeklyPlan: weeklyPlan,
      monthlyPlan: monthlyPlan,
      yearlyPlan: yearlyPlan,
      isLoading: false,
    ));
    _iap.listen(
      onData: _listenToPurchaseUpdated,
      isRestore: true,
    );
  }

  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    if (purchaseDetailsList.isEmpty) return;
    _checkTrialPeriod(purchaseDetailsList);
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _pending(purchaseDetails);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error ||
            purchaseDetails.status == PurchaseStatus.canceled) {
          _canceledOrError();
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          _purchased(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  void _purchased(PurchaseDetails purchaseDetails) {
    final expiryDate = purchaseDetails.getExpiryDate(state.isTrialPeriod);

    emit(state.copy(
      isVip: true,
      expiryDate: expiryDate,
      productId: purchaseDetails.productID,
      weeklyPlan: null,
      monthlyPlan: null,
      yearlyPlan: null,
      isBuying: false,
      isShowAd: false,
    ));

    final subscription = Subscription(
      expiryDate: expiryDate,
      startDate: purchaseDetails.startDate,
      productId: purchaseDetails.productID,
    );

    _updateExpVipUseCase.call(subscription: subscription);
  }

  void _checkTrialPeriod(List<PurchaseDetails> purchaseDetailsList) {
    if (purchaseDetailsList.isEmpty) return;
    if (!state.isTrialPeriod) return;
    if (purchaseDetailsList.any((e) => e.status == PurchaseStatus.restored)) {
      emit(state.copy(isTrialPeriod: false));
    } else {
      final list = purchaseDetailsList
          .where((e) => e.status == PurchaseStatus.purchased);
      if (list.isEmpty) return;
      if (list.length == 1) {
        if (!_checkPurchaseDetails(list.first)) {
          emit(state.copy(isTrialPeriod: false));
        }
      } else {
        emit(state.copy(isTrialPeriod: false));
      }
    }
  }

  bool _checkPurchaseDetails(PurchaseDetails purchaseDetails) {
    return purchaseDetails.productID == Constants.kMonthlyId &&
        int.parse(purchaseDetails.transactionDate!) >
            DateTime.now().millisecondsSinceEpoch - 259200;
  }

  ///Thay đổi vị trí gói
  void selectedPlan(int index) {
    emit(state.copy(indexSelected: index));
  }

  ///Thực hiện đăng ký gói
  Future<void> buyPremium({required ProductDetails productDetails}) async {
    emit(state.copy(isBuying: true));
    await _iap.buyNonConsumable(productDetails);
  }

  ///Yêu cầu khôi phục lại các gói đã đăng ký, trong trường hợp đã mua
  ///nhưng không lên vip
  Future<void> restorePremium() async {
    emit(state.copy(isRestore: true));
    try {
      await _iap.restorePurchases();
      AppRouter.showMessageSuccess(S.current.restore_success);
    } catch (e) {
      AppRouter.showMessageError(S.current.restore_failure);
    } finally {
      emit(state.copy(isRestore: false));
    }
  }

  void _canceledOrError() {
    emit(state.copy(isBuying: false));
  }

  void _pending(PurchaseDetails purchaseDetails) {
    emit(state.copy(isBuying: true));
  }

  @override
  Future<void> close() {
    _iap.dispose();
    return super.close();
  }
}
