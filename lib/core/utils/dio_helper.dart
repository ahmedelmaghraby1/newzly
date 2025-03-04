import 'package:dio/dio.dart';
import 'package:newzly/core/injection/service_locator.dart';
import 'package:newzly/core/utils/api_services.dart';

class DioHelper extends ApiServices<Map<String, dynamic>> {
  final Dio _dio;
  DioHelper(this._dio);

  @override
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
