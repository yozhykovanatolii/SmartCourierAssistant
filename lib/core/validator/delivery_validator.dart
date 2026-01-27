class DeliveryValidator {
  static String? validateCourierComment(String courierComment) {
    if (courierComment.isEmpty) return "The comment must not be empty.";
    if (courierComment.length > 200) {
      return "The comment must not exceed 200 characters";
    }
    return null;
  }
}
