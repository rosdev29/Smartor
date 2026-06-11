class Constants {
  static const googlePlayId = 'https://play.google.com/store/apps/details?id=com.mxgk.calc_pro';

  ///Id của các gói đăng ký in-app-purchase
  static const kWeeklyId = 'calc_weekly_plan';
  static const kMonthlyId = 'calc_monthly_plan';
  static const kYearlyId = 'calc_yearly_plan';

  /// Khóa của sharedprederences
  static const languageCode = 'languageCode';
  static const theme = 'themes';
  static const languageCodeTranslate = 'languageCodeTranslate';
  static const versionQrCode = 'versionQrCode';
  static const barcodeType = 'barcodeType';

  /// Id ads
  static const bannerAndroidId = 'ca-app-pub-3940256099942544/6300978111';

  ///Danh sách các quốc gia sử dụng dấu chấm động
  static List<String> get dotDecimalLocales => [
        'en_US', // Hoa Kỳ
        'en_GB', // Anh
        'en_CA', // Canada
        'en_AU', // Úc
        'en_NZ', // New Zealand
        'zh_CN', // Trung Quốc
        'zh_TW', // Đài Loan
        'ja_JP', // Nhật Bản
        'ko_KR', // Hàn Quốc
        'th_TH', // Thái Lan
        'my_MM', // Myanmar
        'ph_PH', // Philippines
        'sg_SG', // Singapore
        'id_ID', // Indonesia
        'ms_MY', // Malaysia
        'bn_BD', // Bangladesh
      ];
}
