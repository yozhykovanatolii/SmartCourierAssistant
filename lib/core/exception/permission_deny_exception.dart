class PermissionDenyException implements Exception {
  final String errorMessage;

  PermissionDenyException(this.errorMessage);
}
