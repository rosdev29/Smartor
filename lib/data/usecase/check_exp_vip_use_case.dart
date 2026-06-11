import 'package:calc_pro/data/models/subscription.dart';
import 'package:calc_pro/data/repositories/subscription_repository.dart';

class CheckExpVipUseCase {
  final SubscriptionRepository _subscriptionRepository;

  const CheckExpVipUseCase(
      {required SubscriptionRepository subscriptionRepository})
      : _subscriptionRepository = subscriptionRepository;

  ///Lấy ra thông tin gói đăng ký nếu có
  Future<Subscription?> call() => _subscriptionRepository.get();
}
