import 'package:calc_pro/core/di/injector.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/core/theme/theme.dart';
import 'package:calc_pro/logic/cubits/language/language_cubit.dart';
import 'package:calc_pro/logic/cubits/premium/premium_cubit.dart';
import 'package:calc_pro/logic/cubits/theme/theme_cubit.dart';
import 'package:calc_pro/ui/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads_plugin/flutter_ads_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ["3E5C44621F7DCB393A3CB1A8DE226942"]));
  await injector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<PremiumCubit>()..checkVip(false)),
          BlocProvider(create: (_) => getIt<LanguageCubit>()),
          BlocProvider(create: (_) => getIt<ThemeCubit>()..getTheme()),
        ],
        child: Builder(builder: (context) {
          final languageCode = context.watch<LanguageCubit>().state;
          final appColors = context.watch<ThemeCubit>().state;
          return MaterialApp(
            title: 'Smartor',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            theme: AppTheme.getTheme(appColors: appColors),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(languageCode),
            initialRoute: AppRouter.splashScreen,
            routes: AppRouter.routes,
            navigatorKey: AppRouter.navigatorKey,
          );
        }),
      ),
    );
  }
}
