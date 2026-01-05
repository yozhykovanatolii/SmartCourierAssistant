class ResetPasswordException {
  final String errorMessage;

  ResetPasswordException([
    this.errorMessage = 'An unknown reset password exception occurred.',
  ]);

  factory ResetPasswordException.convertFromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return ResetPasswordException(
          'User are not found',
        );
      case 'invalid-email':
        return ResetPasswordException(
          'The email address is not valid.',
        );
      case 'too-many-requests':
        return ResetPasswordException(
          'Too many requests. Please try again later.',
        );
      default:
        return ResetPasswordException();
    }
  }
}
