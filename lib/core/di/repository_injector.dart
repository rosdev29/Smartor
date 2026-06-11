part of 'injector.dart';

void _repositoryInjector()  {


  getIt.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(isar: getIt()));

  getIt.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(isar: getIt()));
}
