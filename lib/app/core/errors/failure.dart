abstract class Failure {
  const Failure(this.message);

  final String message;
}

class AppFailure extends Failure {
  const AppFailure(super.message);
}
