part of 'injector.dart';

void _cubitInjector() {
  getIt.registerLazySingleton(() => PremiumCubit(
        updateExpVipUseCase: getIt(),
        checkExpVipUseCase: getIt(),
        checkShowAdUseCase: getIt(),
      ));

  getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
