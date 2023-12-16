
import 'package:safri/shared/error/error_handler/string_errors_manager.dart';

class ErrorCodes {
  static const int SUCCESS = 200; // success with data
  // local status code
  static const int defaultError = -1;
  //      ------ JSON ------
  static const int unexpectedCharacter = -7;
  // other errors
  static const int assetNotFound = -8;
  static const int responseIsNull = -9;
  // dio errors
  static const int connectTimeOut = 20;
  static const int sendTimeOut = -11;
  static const int receiveTimeOut = 20;
  static const int cancel = -13;
  // http responses
  static const int authError = -14;
}

class ErrorMessages {
  static const String success = StringErrorManager.success; // success with data
  // json
  static const String unexpectedCharacter = StringErrorManager.parsingJsonErr;
  // other errors
  static const String defaultError = StringErrorManager.defaultError;
  static const String assetNotFound = StringErrorManager.assetNotFound;
  static const String responseIsNull = StringErrorManager.responseIsNull;
  // dio error
  static const String connectTimeOut = StringErrorManager.connectTimeOut;
  static const String sendTimeOut = StringErrorManager.sendTimeOut;
  static const String receiveTimeOut = StringErrorManager.receiveTimeOut;
  static const String cancel = StringErrorManager.cancel;
  // http responses
  static const String authError = StringErrorManager.authError;

}
