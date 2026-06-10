part of 'injector.dart';

void _blocInjector() {
  getIt.registerFactory<HomeBloc>(() => HomeBloc(
        calculateUseCase: getIt(),
        insertHistoryUseCase: getIt(),
        checkAppUpdateUseCase: getIt(),
        convertListOffsetsToFileUseCase: getIt(),
        documentTextDetectionUseCase: getIt(),
      ));

  getIt.registerFactory<HistoryBloc>(() => HistoryBloc(
        getListHistoryUseCase: getIt(),
        deleteAllHistoryUseCase: getIt(),
        deleteHistoryUseCase: getIt(),
      ));

  getIt.registerFactory<SplashBloc>(() => SplashBloc());

  getIt.registerFactory<CameraBloc>(() => CameraBloc());

  getIt.registerFactory<ScannerBloc>(() => ScannerBloc(
        documentTextDetectionUseCase: getIt(),
      ));

  getIt.registerFactory<TranslateBloc>(() => TranslateBloc(
        documentTextDetectionUseCase: getIt(),
        getLanguageTranslateUseCase: getIt(),
        setLanguageTranslateUseCase: getIt(),
      ));

  getIt.registerFactory<ViewPdfBloc>(() => ViewPdfBloc());

  getIt.registerFactory<QrGenBloc>(() => QrGenBloc(
        getVersionQrCodeUseCase: getIt(),
        setVersionQrCodeUseCase: getIt(),
      ));

  getIt.registerFactory<BarcodeBloc>(() => BarcodeBloc(
        getBarcodeTypeUseCase: getIt(),
        setBarcodeTypeUseCase: getIt(),
      ));

  getIt.registerFactory<ViewDocxBloc>(() => ViewDocxBloc());
}
