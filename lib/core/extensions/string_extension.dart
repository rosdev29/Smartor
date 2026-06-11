import 'package:calc_pro/core/constants/constants.dart';
import 'package:calc_pro/core/extensions/context_extension.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/ui/routers/app_router.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String get extractNumbers {
    var str = replaceAll(RegExp('II|TI|TỊ'), 'π');
    RegExp regExp = RegExp(
        r'\d{1,20}(?:[.,]\d{1,20})*(?:[.,]\d+)?|(sin|cos|tan|cot|log)\([^\)]*\)|π');
    Iterable<RegExpMatch> matches = regExp.allMatches(str);
    final list = matches.map((match) => match.group(0)!).toList();
    var data = list.join(' + ');
    if (AppRouter.context.isDotDecimalLocale) {
      data = data.replaceAll(',', '');
    } else {
      data = data.replaceAll('.', '');
    }
    return data;
  }

  String get format {
    var value = this;
    RegExp reg;
    if (AppRouter.context.isDotDecimalLocale) {
      value = value.replaceAll(',', '');
      reg = RegExp(r'(?<!\.)\b(\d+)');
    } else {
      value = value.replaceAll('.', '');
      reg = RegExp(r'(?<!,)\b(\d+)');
    }
    value = value.replaceAllMapped(reg, (match) {
      if (match.group(0) == null) return value;
      var num = int.parse(match.group(0)!);

      final localeString =
          AppRouter.context.isDotDecimalLocale ? 'en_US' : 'vi_VN';
      var formattedNumber =
          NumberFormat.decimalPattern(localeString).format(num);
      return formattedNumber;
    });
    if (value.endsWith('.0') || value.endsWith(',0')) {
      value = value.substring(0, value.length - 2);
    }
    return value;
  }

  String get toProductName {
    var name = S.current.weekly_pro;
    if (this == Constants.kMonthlyId) {
      name = S.current.monthly_pro;
    } else if (this == Constants.kYearlyId) {
      name = S.current.yearly_pro;
    }
    return name;
  }
}
