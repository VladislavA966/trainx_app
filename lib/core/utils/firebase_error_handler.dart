import 'package:firebase_auth/firebase_auth.dart';
import 'package:trainx_app/core/constants/network_constants.dart';

import 'errors_handler.dart';

class AuthExceptionHandler {
  static Failure handleException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return ServerFailure(strInvalidEmail);
      case "wrong-password":
        return ServerFailure(strWrongPassword);
      case "user-not-found":
        return ServerFailure(strUserNotFound);
      case "user-disabled":
        return ServerFailure(strUserDisabled);
      case "too-many-requests":
        return ServerFailure(strTooManyRequests);
      case "operation-not-allowed":
        return ServerFailure(strOperationNotAllowed);
      case "email-already-in-use":
        return ServerFailure(strEmailAlreadyExists);
      default:
        return ServerFailure(strUnknownFirebaseError);
    }
  }
}
