
import 'error_source.dart';
import 'failure.dart';

enum DataSourceOtherError { assetNotFound, defaultError, responseIsNull }

Failure handleOtherError(DataSourceOtherError error) {
  switch (error) {
    case DataSourceOtherError.assetNotFound:
      return DataSourceOtherError.assetNotFound.getFailure();
    case DataSourceOtherError.defaultError:
      return DataSourceOtherError.defaultError.getFailure();
    case DataSourceOtherError.responseIsNull:
      return DataSourceOtherError.responseIsNull.getFailure();
  }
}

extension DataSourceExtension on DataSourceOtherError {
  Failure getFailure() {
    switch (this) {
      case DataSourceOtherError.defaultError:
        return Failure(ErrorCodes.defaultError, ErrorMessages.defaultError,TypeMsg.error);
      case DataSourceOtherError.assetNotFound:
        return Failure(ErrorCodes.assetNotFound, ErrorMessages.assetNotFound,TypeMsg.error);
      case DataSourceOtherError.responseIsNull:
        return Failure(ErrorCodes.responseIsNull, ErrorMessages.responseIsNull,TypeMsg.error);

    }
  }
}
