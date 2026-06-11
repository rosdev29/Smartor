part of 'injector.dart';

void _useCaseInjector() {
  getIt.registerLazySingleton<CalculateUseCase>(() => CalculateUseCase());

  getIt.registerLazySingleton<CheckExpVipUseCase>(
      () => CheckExpVipUseCase(subscriptionRepository: getIt()));

  getIt.registerLazySingleton<UpdateExpVipUseCase>(
      () => UpdateExpVipUseCase(subscriptionRepository: getIt()));

  getIt.registerLazySingleton<InsertHistoryUseCase>(
      () => InsertHistoryUseCase(historyRepository: getIt()));

  getIt.registerLazySingleton<GetListHistoryUseCase>(
      () => GetListHistoryUseCase(historyRepository: getIt()));

  getIt.registerLazySingleton<DeleteAllHistoryUseCase>(
      () => DeleteAllHistoryUseCase(historyRepository: getIt()));

  getIt.registerLazySingleton<DeleteHistoryUseCase>(
      () => DeleteHistoryUseCase(historyRepository: getIt()));

  getIt.registerLazySingleton<CheckAppUpdateUseCase>(
      () => CheckAppUpdateUseCase());

  getIt.registerLazySingleton<DocumentTextDetectionUseCase>(
      () => DocumentTextDetectionUseCase(textRecognizer: getIt()));

  getIt.registerLazySingleton<ConvertListOffsetsToBytesUseCase>(
      () => ConvertListOffsetsToBytesUseCase());

  getIt.registerLazySingleton<GetLanguageTranslateUseCase>(
      () => GetLanguageTranslateUseCase());

  getIt.registerLazySingleton<SetLanguageTranslateUseCase>(
      () => SetLanguageTranslateUseCase());

  getIt.registerLazySingleton<CheckShowAdUseCase>(() => CheckShowAdUseCase());

  getIt.registerLazySingleton<GetVersionQrCodeUseCase>(
      () => GetVersionQrCodeUseCase());

  getIt.registerLazySingleton<SetVersionQrCodeUseCase>(
      () => SetVersionQrCodeUseCase());

  getIt.registerLazySingleton<SetBarcodeTypeUseCase>(
      () => SetBarcodeTypeUseCase());

  getIt.registerLazySingleton<GetBarcodeTypeUseCase>(
      () => GetBarcodeTypeUseCase());
}
