class OrdersNotFoundException implements Exception {
  final String errorMessage;

  OrdersNotFoundException(this.errorMessage);
}
