class RouteNotFoundException implements Exception {
  final String errorMessage;

  RouteNotFoundException(this.errorMessage);
}
