import 'package:dio/dio.dart';
import 'package:newzly/core/models/errors/failure_model.dart';

class NetworkFailureModel extends Failure {
  NetworkFailureModel({required super.errorMessage});
  factory NetworkFailureModel.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailureModel(
          errorMessage: 'Connection timeout with api server',
        );
      case DioExceptionType.sendTimeout:
        return NetworkFailureModel(
          errorMessage: 'Send timeout with api server',
        );

      case DioExceptionType.receiveTimeout:
        return NetworkFailureModel(
          errorMessage: 'Recieve timeout with api server',
        );

      case DioExceptionType.badCertificate:
        return NetworkFailureModel(
          errorMessage: 'Bad certificate with api server',
        );

      case DioExceptionType.badResponse:
        return NetworkFailureModel.fromResponse(
          statusCode: error.response!.statusCode ?? 500,
        );

      case DioExceptionType.cancel:
        return NetworkFailureModel(
          errorMessage: 'Request to the server was cancelled',
        );

      case DioExceptionType.connectionError:
        return NetworkFailureModel(
          errorMessage: 'No or bad internet connection',
        );

      case DioExceptionType.unknown:
        return NetworkFailureModel(
          errorMessage: 'Ops! there was an error, please try again',
        );
    }
  }
  factory NetworkFailureModel.fromResponse({required int statusCode}) {
    if (statusCode == 404) {
      return NetworkFailureModel(
        errorMessage: 'Can\'t fount the server you addressed',
      );
    }
    if (statusCode == 500) {
      return NetworkFailureModel(
        errorMessage: 'Can\'t fount the server you addressed',
      );
    }
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return NetworkFailureModel(
        errorMessage: 'Can\'t fount the server you addressed',
      );
    }
    return NetworkFailureModel(errorMessage: 'There was an Error, try again');
  }
}
