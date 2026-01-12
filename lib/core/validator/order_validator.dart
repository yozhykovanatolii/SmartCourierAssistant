class OrderValidator {
  static String? validateAddress(String address) {
    if (address.isEmpty) return 'Address must not be empty.';
    return null;
  }
}
