part of '../core.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PremiumCubit>().state;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isVip) AppRouter.pop();
    });
    return SafeArea(
        top: false,
        child: Scaffold(
          body: state.isLoading
              ? Stack(
                  children: [
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    Positioned(top: 44.h, left: 12.w, child: BackButton()),
                  ],
                )
              : Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 32.h),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: IconButton(
                              onPressed: () => AppRouter.pop(),
                              icon: Icon(Icons.close)),
                        ),
                        Shimmer.fromColors(
                          baseColor: Color(0xFFFFD700),
                          highlightColor: Colors.white,
                          child: GradientText(
                            style: context.textTheme.titleLarge,
                            'PREMIUM',
                            colors: [
                              Color(0xFFFFD700),
                              Color(0xFFFFC107),
                              Color(0xFFFFF8E1),
                              Color(0xFFFFA000),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.w),
                        _PurchaseListTitleWidget(
                          title: S.current.remove_ads_title,
                          content: S.current.remove_ads_content,
                          image: 'assets/images/block.png',
                        ),
                        _PurchaseListTitleWidget(
                          title: S.current.priority_support_title,
                          content: S.current.priority_support_content,
                          image: 'assets/images/customer-service.png',
                        ),
                        SizedBox(height: 8.w),
                        Container(
                          height: 160.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.w)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 12.h),
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                S.current.thank_you_premium_title,
                                style: context.textTheme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(child: SizedBox()),
                              Text(
                                textAlign: TextAlign.center,
                                S.current.thank_you_premium_content,
                                style: context.textTheme.labelSmall,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.w),
                        const _PurchaseListProductWidget(),
                        Platform.isAndroid
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  S.current.subscription_terms,
                                  style: context.textTheme.labelSmall,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
