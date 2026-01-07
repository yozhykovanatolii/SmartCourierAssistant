class UserNotFoundException implements Exception {
  final String errorMessage;

  UserNotFoundException(this.errorMessage);
}
