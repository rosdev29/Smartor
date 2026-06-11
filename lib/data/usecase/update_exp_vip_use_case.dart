import 'package:calc_pro/data/models/subscription.dart';
import 'package:calc_pro/data/repositories/subscription_repository.dart';

class UpdateExpVipUseCase {
  final SubscriptionRepository _subscriptionRepository;

  const UpdateExpVipUseCase(
      {required SubscriptionRepository subscriptionRepository})
      : _subscriptionRepository = subscriptionRepository;

  ///Lưu(cập nhật) gói đăng ký vào sharedpreferences
  Future<int> call({required Subscription subscription}) =>
      _subscriptionRepository.save(subscription: subscription);
}
