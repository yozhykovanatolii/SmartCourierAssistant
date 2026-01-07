class PhotoNotSelectedException implements Exception {
  final String errorMessage;

  PhotoNotSelectedException(this.errorMessage);
}
