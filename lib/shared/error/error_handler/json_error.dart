
import 'error_source.dart';
import 'failure.dart';

Failure handleJsonError(FormatException error) {
  return Failure(ErrorCodes.unexpectedCharacter, "${error.message} ", TypeMsg.error);
}
