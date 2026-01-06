class RegisterException implements Exception {
  final String message;

  RegisterException([
    this.message = 'An unknown register exception occurred.',
  ]);

  factory RegisterException.convertFromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return RegisterException(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return RegisterException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return RegisterException(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return RegisterException(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return RegisterException(
          'Please enter a stronger password.',
        );
      default:
        return RegisterException();
    }
  }
}
