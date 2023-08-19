import 'package:get_it/get_it.dart';
import 'package:test_task_kz/core/utils/dio_settings.dart';
import 'package:test_task_kz/core/utils/shared_preferences.dart';
import 'package:test_task_kz/features/login/data/datasource/login_datasource.dart';
import 'package:test_task_kz/features/login/data/repository/login_repository_impl.dart';
import 'package:test_task_kz/features/profile/data/datasource/profile_datasource.dart';
import 'package:test_task_kz/features/profile/data/repository/profile_repository_impl.dart';

final serviceLocator = GetIt.I;

void setupLocator() {
  StorageRepository.getInstance();
  serviceLocator.registerLazySingleton(() => DioSettings());

  serviceLocator.registerLazySingleton(() => LoginDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => LoginRepositoryImpl(dataSource: serviceLocator<LoginDataSourceImpl>()));
  serviceLocator.registerLazySingleton(
      () => ProfileDatasourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() =>
      ProfileRepositoryImpl(datasource: serviceLocator<ProfileDatasourceImpl>()));
}


