import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:newzly/core/utils/api_services.dart';
import 'package:newzly/core/utils/dio_helper.dart';
import 'package:newzly/features/home/data/data_sources/home_local_data_source.dart';
import 'package:newzly/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:newzly/features/home/data/repositories/home_repository_imp.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_business_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_entertainment_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_general_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_health_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_sports_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_technology_news_use_case.dart';

GetIt getIt = GetIt.instance;
String baseUrl =
    dotenv.env['base_url'] ?? 'https://newsapi.org/v2/top-headlines?';
String apiKey = dotenv.env['api_key'] ?? 'b928c8f387064fc98c047920c08c874e';
initGetIt() {
  // Dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 50),
          receiveTimeout: const Duration(seconds: 50),
        ),
      )
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: true,
          responseBody: true,
          logPrint: (object) => log(object.toString()),
        ),
      ),
  );
  getIt.registerLazySingleton<ApiServices<dynamic>>(() => DioHelper(getIt()));

  // Data sources

  //Remote data sources
  getIt.registerLazySingleton<HomeRemoteDataSourceImplementation>(
    () => HomeRemoteDataSourceImplementation(dioHelper: getIt()),
  );

  //Local data sources
  getIt.registerLazySingleton<HomeLocalDataSourceImplementation>(
    () => HomeLocalDataSourceImplementation(),
  );
  // Repositories
  getIt.registerLazySingleton<HomeRepositoryImplementation>(
    () => HomeRepositoryImplementation(
      homeRemoteDataSource: getIt(),
      homeLocalDataSource: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton<FetchGeneralNewsUseCase>(
    () => FetchGeneralNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchSportsNewsUseCase>(
    () => FetchSportsNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchHealthNewsUseCase>(
    () => FetchHealthNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchTechnologyNewsUseCase>(
    () => FetchTechnologyNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchEntertainmentNewsUseCase>(
    () => FetchEntertainmentNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchBusinessNewsUseCase>(
    () => FetchBusinessNewsUseCase(getIt()),
  );

  //Cubits
}
