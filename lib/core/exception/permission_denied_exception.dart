class PermissionDeniedException implements Exception {
  final String errorMessage;

  PermissionDeniedException(this.errorMessage);
}
