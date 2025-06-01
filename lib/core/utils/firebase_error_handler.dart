import 'package:firebase_auth/firebase_auth.dart';
import 'package:trainx_app/core/constants/network_constants.dart';

import 'errors_handler.dart';

enum FirebaseAuthErrorCode {
  invalidEmail,
  wrongPassword,
  userNotFound,
  userDisabled,
  tooManyRequests,
  operationNotAllowed,
  emailAlreadyInUse,
  weakPassword,
  networkRequestFailed,
  invalidCredential,
  expiredActionCode,
  invalidVerificationCode,
  missingVerificationCode,
  unknown;

  static FirebaseAuthErrorCode fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return FirebaseAuthErrorCode.invalidEmail;
      case 'wrong-password':
        return FirebaseAuthErrorCode.wrongPassword;
      case 'user-not-found':
        return FirebaseAuthErrorCode.userNotFound;
      case 'user-disabled':
        return FirebaseAuthErrorCode.userDisabled;
      case 'too-many-requests':
        return FirebaseAuthErrorCode.tooManyRequests;
      case 'operation-not-allowed':
        return FirebaseAuthErrorCode.operationNotAllowed;
      case 'email-already-in-use':
        return FirebaseAuthErrorCode.emailAlreadyInUse;
      case 'weak-password':
        return FirebaseAuthErrorCode.weakPassword;
      case 'network-request-failed':
        return FirebaseAuthErrorCode.networkRequestFailed;
      case 'invalid-credential':
        return FirebaseAuthErrorCode.invalidCredential;
      case 'expired-action-code':
        return FirebaseAuthErrorCode.expiredActionCode;
      case 'invalid-verification-code':
        return FirebaseAuthErrorCode.invalidVerificationCode;
      case 'missing-verification-code':
        return FirebaseAuthErrorCode.missingVerificationCode;
      default:
        return FirebaseAuthErrorCode.unknown;
    }
  }
}

class AuthExceptionHandler {
  static Failure handleException(FirebaseAuthException e) {
    final errorCode = FirebaseAuthErrorCode.fromCode(e.code);
    switch (errorCode) {
      case FirebaseAuthErrorCode.invalidEmail:
        return ServerFailure(strInvalidEmail);
      case FirebaseAuthErrorCode.wrongPassword:
        return ServerFailure(strWrongPassword);
      case FirebaseAuthErrorCode.userNotFound:
        return ServerFailure(strUserNotFound);
      case FirebaseAuthErrorCode.userDisabled:
        return ServerFailure(strUserDisabled);
      case FirebaseAuthErrorCode.tooManyRequests:
        return ServerFailure(strTooManyRequests);
      case FirebaseAuthErrorCode.operationNotAllowed:
        return ServerFailure(strOperationNotAllowed);
      case FirebaseAuthErrorCode.emailAlreadyInUse:
        return ServerFailure(strEmailAlreadyExists);
      case FirebaseAuthErrorCode.weakPassword:
        return ServerFailure("Пароль слишком простой");
      case FirebaseAuthErrorCode.networkRequestFailed:
        return ServerFailure("Проблемы с сетью. Проверьте подключение.");
      case FirebaseAuthErrorCode.invalidCredential:
        return ServerFailure("Недействительные учетные данные.");
      case FirebaseAuthErrorCode.expiredActionCode:
        return ServerFailure("Срок действия кода истек.");
      case FirebaseAuthErrorCode.invalidVerificationCode:
        return ServerFailure("Неверный код подтверждения.");
      case FirebaseAuthErrorCode.missingVerificationCode:
        return ServerFailure("Код подтверждения не был введен.");
      case FirebaseAuthErrorCode.unknown:
        return ServerFailure(strUnknownFirebaseError);
    }
  }
}
