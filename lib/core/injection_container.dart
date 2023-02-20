import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:omnipro/core/providers/url_provider.dart';
import 'package:omnipro/features/photo_list/domain/repository/photo_repository.dart';
import 'package:omnipro/features/photo_list/domain/use_cases/get_photo_list_use_case.dart';

import '../features/photo_list/data/data_source/photo_data_source.dart';
import '../features/photo_list/data/repository/photo_repository_impl.dart';
import '../features/photo_list/presentation/bloc/photo_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /// BLOC
  sl.registerLazySingleton(() => PhotoBloc(getPhotoListUseCase: sl()));

  ///USE CASE
  sl.registerLazySingleton(() => GetPhotoListUseCase(photoRepository: sl()));

  /// REPOSITORY
  sl.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImpl(photoDataSource: sl()));

  /// DATASOURCE
  sl.registerLazySingleton<PhotoDataSource>(() => PhotoDataSource(httpClient: sl(), urlProvider: sl()));

  /// Core
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => UrlProvider());
}
