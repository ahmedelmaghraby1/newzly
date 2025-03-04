import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:newzly/core/utils/api_services.dart';
import 'package:newzly/core/utils/dio_helper.dart';

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
}
