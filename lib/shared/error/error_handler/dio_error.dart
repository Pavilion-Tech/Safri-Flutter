import 'package:dio/dio.dart';

import '../failures.dart';
import 'error_source.dart';
import 'failure.dart';



enum DataSourceDioError { connectTimeOut, sendTimeOut, receiveTimeOut, defaultError, cancel }

Failure handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return DataSourceDioError.connectTimeOut.getFailure();
    case DioErrorType.sendTimeout:
      return DataSourceDioError.sendTimeOut.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSourceDioError.receiveTimeOut.getFailure();
    case DioErrorType.cancel:
      return DataSourceDioError.cancel.getFailure();
    case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      return DataSourceDioError.defaultError.getFailure();
    case DioExceptionType.badResponse:
      return Failure(0, error.error.toString(), TypeMsg.error);
    case DioExceptionType.connectionError:
      // TODO: Handle this case.
      return DataSourceDioError.defaultError.getFailure();
    case DioExceptionType.unknown:
      // TODO: Handle this case.
      return DataSourceDioError.defaultError.getFailure();
  }
}

extension DataSourceExtension on DataSourceDioError {
  Failure getFailure() {
    switch (this) {
      case DataSourceDioError.connectTimeOut:
        return Failure(ErrorCodes.connectTimeOut, ErrorMessages.connectTimeOut, TypeMsg.error);
      case DataSourceDioError.sendTimeOut:
        return Failure(ErrorCodes.sendTimeOut, ErrorMessages.sendTimeOut, TypeMsg.error);
      case DataSourceDioError.receiveTimeOut:
        return Failure(ErrorCodes.receiveTimeOut, ErrorMessages.receiveTimeOut, TypeMsg.error);
      case DataSourceDioError.defaultError:
        return Failure(ErrorCodes.defaultError, ErrorMessages.defaultError, TypeMsg.error);
      case DataSourceDioError.cancel:
        return Failure(ErrorCodes.cancel, ErrorMessages.cancel, TypeMsg.error);
    }
  }
}
