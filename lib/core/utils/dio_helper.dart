import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:newzly/core/injection/injector.dart';

class DioHelper {
  final Dio _dio = Dio(
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
    );

  Future<Map<String, dynamic>> get({
    String? base,
    required String endPoint,
    data,
    query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    Map<String, dynamic> headers = {
      'Authorization': apiKey,
      'X-Api-Key': apiKey,
    };
    Response response = await _dio.get(
      baseUrl + endPoint,
      queryParameters: query,
      cancelToken: cancelToken,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
