part of 'injector.dart';

void _repositoryInjector()  {


  getIt.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(isar: getIt()));

}
