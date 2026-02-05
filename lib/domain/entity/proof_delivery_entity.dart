class ProofDeliveryEntity {
  final String courierComment;
  final List<String> orderPhotos;
  final DateTime confirmedAt;

  ProofDeliveryEntity({
    required this.courierComment,
    required this.orderPhotos,
    required this.confirmedAt,
  });

  factory ProofDeliveryEntity.initial() {
    return ProofDeliveryEntity(
      courierComment: '',
      orderPhotos: [],
      confirmedAt: DateTime.now(),
    );
  }

  ProofDeliveryEntity copyWith({
    String? courierComment,
    List<String>? orderPhotos,
    DateTime? confirmedAt,
  }) {
    return ProofDeliveryEntity(
      courierComment: courierComment ?? this.courierComment,
      orderPhotos: orderPhotos ?? this.orderPhotos,
      confirmedAt: confirmedAt ?? this.confirmedAt,
    );
  }
}
