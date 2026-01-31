import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/university_remote_datasource.dart';
import 'data/repositories/university_repository_impl.dart';
import 'domain/repositories/university_repository.dart';
import 'domain/usecases/get_universities.dart';
import 'presentation/providers/university_provider.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // 1. Providers
  sl.registerFactory(
        () => UniversityProvider(getUniversities: sl()),
  );

  // 2. Use Cases
  sl.registerLazySingleton(() => GetUniversities(sl()));

  // 3. Repositories
  sl.registerLazySingleton<UniversityRepository>(
        () => UniversityRepositoryImpl(remoteDataSource: sl()),
  );

  // 4. Data Sources
  sl.registerLazySingleton<UniversityRemoteDataSource>(
        () => UniversityRemoteDataSourceImpl(dio: sl()),
  );

  // 5. External (Dio)
  sl.registerLazySingleton(() => Dio());
}