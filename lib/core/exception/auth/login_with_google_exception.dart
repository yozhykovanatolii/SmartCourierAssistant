class LoginWithGoogleException implements Exception {
  final String message;

  LoginWithGoogleException([
    this.message = 'An unknown authorization with Google exception occurred.',
  ]);

  factory LoginWithGoogleException.convertFromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return LoginWithGoogleException(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return LoginWithGoogleException(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return LoginWithGoogleException(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return LoginWithGoogleException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return LoginWithGoogleException(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return LoginWithGoogleException(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return LoginWithGoogleException(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return LoginWithGoogleException(
          'The credential verification ID received is invalid.',
        );
      default:
        return LoginWithGoogleException();
    }
  }
}
