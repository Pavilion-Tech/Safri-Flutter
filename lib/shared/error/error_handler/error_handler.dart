import 'package:dio/dio.dart';

import 'dio_error.dart';
import 'failure.dart';
import 'json_error.dart';
import 'other_errors.dart';



class ErrorHandlerCustom implements Exception {
  late Failure failure;

  ErrorHandlerCustom.handle(dynamic error) {
    // dio error so its an error from response of the API or from dio itself
    if (error is DioError) {
      failure = handleError(error);
    }
    // json error parser
    if (error is FormatException) {
      failure = handleJsonError(error);
    }
    // other errors
    else if (error is DataSourceOtherError) {
      failure = handleOtherError(error);
    }
    // default error
    else {
      failure = Failure(-1, error.toString(),TypeMsg.error);
    }
  }
}

