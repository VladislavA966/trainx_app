import 'package:trainx_app/core/constants/network_constants.dart';

class AuthExceptionHandler {
  // ignore: type_annotate_public_apis
  static AuthResultStatus handleException(e) {
    AuthResultStatus status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
        status = AuthResultStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static String generateExceptionMessage(AuthResultStatus exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = strInvalidEmail;
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = strWrongPassword;
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = strUserNotFound;
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = strUserDisabled;
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = strTooManyRequests;
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = strOperationNotAllowed;
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = strEmailAlreadyExists;
        break;
      default:
        errorMessage = strUnknownFirebaseError;
    }

    return errorMessage;
  }
}

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}
