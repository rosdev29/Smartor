import 'package:shared_preferences/shared_preferences.dart';

class CheckShowAdUseCase {
  Future<bool> call() async {
    final spf = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;
    final showAd = spf.getInt('showAd');
    if (showAd == null) {
      spf.setInt('showAd', now);
      return false;
    }
    return now - showAd > 259200000;
  }
}
