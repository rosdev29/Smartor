import 'package:calc_pro/core/constants/constants.dart';
import 'package:iap_quick/iap_quick.dart';

extension PurchaseDetailsExtension on PurchaseDetails {

  ///Lấy ra transactionDate của gói đăng ký dưới dạng mili giây
  ///Bạn phải đảm bảo rằng transactionDate != null, nếu không sẽ xảy ra lỗi
  int get milliseconds => int.parse(transactionDate!);

  ///Lấy ra transactionDate của gói đăng ký dưới dạng DateTime
  ///Bạn phải đảm bảo rằng transactionDate != null, nếu không sẽ xảy ra lỗi
  DateTime get startDate => DateTime.fromMillisecondsSinceEpoch(milliseconds);

  ///Tính toán thời ngày hết hạn của gói, kiểu dữ liệu trả về: DateTime
  ///Bạn phải đảm bảo rằng transactionDate != null, nếu không sẽ xảy ra lỗi
  DateTime getExpiryDate(bool isTrialPeriod) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final totalSeconds = productID == Constants.kWeeklyId
        ? 604800
        : productID == Constants.kYearlyId
            ? 31536000
            : isTrialPeriod
                ? 259200
                : 2592000;

    final remainingSeconds = totalSeconds - (now - milliseconds) % totalSeconds;
    final expiryInSeconds = now + remainingSeconds;
    return DateTime.fromMillisecondsSinceEpoch(expiryInSeconds);
  }
}
