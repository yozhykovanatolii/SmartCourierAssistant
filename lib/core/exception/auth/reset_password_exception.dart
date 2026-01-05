class ResetPasswordException {
  final String errorMessage;

  ResetPasswordException([
    this.errorMessage = 'An unknown reset password exception occurred.',
  ]);

  factory ResetPasswordException.convertFromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return ResetPasswordException(
          'The email address is not valid.',
        );
      case 'too-many-requests':
        return ResetPasswordException(
          'Too many requests. Please try again later.',
        );
      case 'network-request-failed':
        return ResetPasswordException('Network error.');
      default:
        return ResetPasswordException();
    }
  }
}
