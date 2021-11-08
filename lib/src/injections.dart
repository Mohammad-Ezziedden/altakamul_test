import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/src/core/utils/connectivity/ConnectivityBloc/connectivity_bloc.dart';

import 'package:test/src/data/data_sources/questions_api.dart';
import 'package:test/src/data/data_sources/questions_shared_prefs.dart';
import 'package:test/src/data/repositories/questions_repo_empl.dart';
import 'package:test/src/domain/repositories/questions_repository.dart';

import 'core/utils/AppLogger.dart';
import 'core/utils/network/logger_interceptor.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  initRootLogger();
  sl.registerSingleton<ConnectivityHelper>(ConnectivityHelper());
  sl.registerSingletonAsync<Dio>(() async {
    final dio = Dio(BaseOptions(
        baseUrl: "https://api.stackexchange.com/",
        validateStatus: (s) {
          return s! < 300;
        },
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "charset": "utf-8",
          "Accept-Charset": "utf-8",
          "Accept-Language": "en"
        },
        responseType: ResponseType.json));

    dio.interceptors.add(LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    ));
    return dio;
  });
  await sl.isReady<Dio>();
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<QuestionsSharedPrefs>(
      () => QuestionsSharedPrefs(sharedPrefs));
  sl.registerLazySingleton<QuestionsApi>(() => QuestionsApi());
  sl.registerLazySingleton<QuestionsRepository>(
      () => QuestionsRepositoryImpl(sl(), sl()));

  return;
}
