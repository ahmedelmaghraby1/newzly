import 'package:dio/dio.dart';
import 'package:newzly/core/models/errors/failure_model.dart';

class NetworkFailureModel extends Failure {
  NetworkFailureModel({required super.errorMessage});
  factory NetworkFailureModel.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailureModel(errorMessage: 'connectionTimeOut');
      case DioExceptionType.sendTimeout:
        return NetworkFailureModel(errorMessage: 'sendTimeOut');

      case DioExceptionType.receiveTimeout:
        return NetworkFailureModel(errorMessage: 'recieveTimeOut');

      case DioExceptionType.badCertificate:
        return NetworkFailureModel(errorMessage: 'badCertificate');

      case DioExceptionType.badResponse:
        return NetworkFailureModel.fromResponse(
          statusCode: error.response!.statusCode ?? 500,
        );

      case DioExceptionType.cancel:
        return NetworkFailureModel(errorMessage: 'requestCancelled');

      case DioExceptionType.connectionError:
        return NetworkFailureModel(errorMessage: 'noInternetConnection');

      case DioExceptionType.unknown:
        return NetworkFailureModel(errorMessage: 'ops');
    }
  }
  factory NetworkFailureModel.fromResponse({required int statusCode}) {
    if (statusCode == 404) {
      return NetworkFailureModel(errorMessage: 'serverNotFound');
    }
    if (statusCode == 500) {
      return NetworkFailureModel(errorMessage: 'serverNotFound');
    }
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return NetworkFailureModel(errorMessage: 'serverNotFound');
    }
    return NetworkFailureModel(errorMessage: 'error');
  }
}
