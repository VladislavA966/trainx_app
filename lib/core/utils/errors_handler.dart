abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("No internet connection.");
}

class FirestoreFailure extends Failure {
  const FirestoreFailure(super.message);
}
