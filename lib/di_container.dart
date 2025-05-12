
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:bxanh_vendor/theme/controllers/theme_controller.dart';


import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

import 'features/example_mobilio/controller/mobilio_controller.dart';
import 'features/example_mobilio/domain/repositories/mobilio_respository.dart';
import 'features/example_mobilio/domain/repositories/mobilio_respository_interface.dart';
import 'features/example_mobilio/domain/services/mobilio_service.dart';
import 'features/example_mobilio/domain/services/mobilio_service_interface.dart';

import 'flavor_config.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(
      () => DioClient(FlavorConfig.apiBaseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());

  //interface
  MobilioRespoInterface mobilioRespoInterface = MobilioRepository(dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => mobilioRespoInterface);



  MobilioServiceInterface mobilioServiceInterface = MobilioSerivce(repo: sl());
  sl.registerLazySingleton(() => mobilioServiceInterface);


  //services
  sl.registerLazySingleton(() => MobilioSerivce(repo: sl()));


  // Repository
  sl.registerLazySingleton(() => MobilioRepository(sharedPreferences: sl(), dioClient: sl()));


  // Controller
  sl.registerFactory(() => MobilioController(serviceInterface: sl()));
  sl.registerFactory(() => ThemeController(sharedPreferences: sl()));

}
