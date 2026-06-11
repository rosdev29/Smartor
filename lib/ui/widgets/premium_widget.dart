import 'package:calc_pro/core/extensions/context_extension.dart';
import 'package:calc_pro/core/extensions/date_time_extension.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/logic/cubits/premium/premium_cubit.dart';
import 'package:calc_pro/ui/routers/app_router.dart';
import 'package:calc_pro/ui/widgets/anim_button.dart';
import 'package:calc_pro/ui/widgets/load_lottie_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_tooltip/super_tooltip.dart';

class PremiumWidget extends StatefulWidget {
  const PremiumWidget({super.key});

  @override
  State<PremiumWidget> createState() => _PremiumWidgetState();
}

class _PremiumWidgetState extends State<PremiumWidget> {
  late SuperTooltipController _controllerTooltip;

  @override
  void initState() {
    super.initState();
    _controllerTooltip = SuperTooltipController();
  }

  @override
  void dispose() {
    _controllerTooltip.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PremiumCubit>().state;
    final child = state.isVip
        ? SuperTooltip(
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoadLottieJson(
                  fit: BoxFit.contain,
                  asset: 'premium',
                  width: 44.w,
                  height: 44.w,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.membership,
                      style: context.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      state.expiryDate!.yearMonthDay,
                      style: context.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            controller: _controllerTooltip,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                color: Colors.transparent,
              ),
              child: LoadLottieJson(
                fit: BoxFit.cover,
                asset: 'premium',
                width: 44.w,
                height: 44.w,
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              color: Colors.transparent,
            ),
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.all(6.w),
            child: LoadLottieJson(
              fit: BoxFit.cover,
              asset: 'un_premium',
              width: 28.w,
              height: 28.w,
            ),
          );
    return AnimButton(
      child: child,
      onTap: () {
        state.isVip
            ? _controllerTooltip.showTooltip()
            : AppRouter.pushNamed(AppRouter.subscriptionScreen);
      },
    );
  }
}
