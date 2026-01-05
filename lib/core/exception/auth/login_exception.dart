class LoginException implements Exception {
  final String message;

  LoginException([
    this.message = 'An unknown authorization exception occurred.',
  ]);

  factory LoginException.convertFromCode(
    String code,
  ) {
    switch (code) {
      case 'invalid-email':
        return LoginException(
          'Invalid email, try again',
        );
      case 'user-disabled':
        return LoginException(
          'User are disabled',
        );
      case 'wrong-password':
        return LoginException(
          'Password is wrong',
        );
      case 'operation-not-allowed':
        return LoginException(
          'The operation is not allowed',
        );
      case 'user-token-expired':
        return LoginException(
          'The user\'s token is expired',
        );
      case 'invalid-credential':
        return LoginException(
          'Invalid credential',
        );
      default:
        return LoginException();
    }
  }
}
