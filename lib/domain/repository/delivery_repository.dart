abstract interface class DeliveryRepository {
  Future<void> createProofOfDelivery(
    String orderId,
    String courierComment,
    List<String> orderPhotos,
  );
}
