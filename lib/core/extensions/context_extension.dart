import 'package:calc_pro/core/constants/constants.dart';
import 'package:calc_pro/core/theme/colors.dart';
import 'package:calc_pro/logic/cubits/language/language_cubit.dart';
import 'package:calc_pro/logic/cubits/theme/theme_cubit.dart';
import 'package:calc_pro/ui/widgets/dialog_delete_all_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/cubits/premium/premium_cubit.dart';

enum DialogCustom {
  deleteAllHistory,
}

extension ContextExtension on BuildContext {
  bool get isShowAd => read<PremiumCubit>().state.isShowAd;

  String get localeString => read<LanguageCubit>().state;

  bool get isDotDecimalLocale =>
      Constants.dotDecimalLocales.any((e) => e.contains(localeString));

  AppColors get appColors => read<ThemeCubit>().state;

  TextTheme get textTheme => Theme.of(this).textTheme;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  bool get isTablet => width >= 600 && width / height <= 0.75;

  Future<T?> showDialogCustom<T>({
    required DialogCustom type,
    bool barrierDismissible = true,
    Object? args,
  }) =>
      showDialog(
          context: this,
          barrierDismissible: barrierDismissible,
          builder: (_) {
            Widget dialogContent;
            switch (type) {
              case DialogCustom.deleteAllHistory:
                dialogContent = const DialogDeleteAllHistory();
                break;
            }
            return Dialog(
                clipBehavior: Clip.hardEdge,
                backgroundColor: appColors.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.w),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: dialogContent,
                ));
          });
}
