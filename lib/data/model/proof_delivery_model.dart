import 'package:cloud_firestore/cloud_firestore.dart';

class ProofDeliveryModel {
  final String courierComment;
  final List<String> orderPhotos;
  final DateTime confirmedAt;

  ProofDeliveryModel({
    required this.courierComment,
    required this.orderPhotos,
    required this.confirmedAt,
  });

  ProofDeliveryModel copyWith({
    String? courierComment,
    List<String>? orderPhotos,
    DateTime? confirmedAt,
  }) {
    return ProofDeliveryModel(
      courierComment: courierComment ?? this.courierComment,
      orderPhotos: orderPhotos ?? this.orderPhotos,
      confirmedAt: confirmedAt ?? this.confirmedAt,
    );
  }

  factory ProofDeliveryModel.fromFirestore(
    Map<String, dynamic> json,
  ) {
    return ProofDeliveryModel(
      courierComment: json['courierComment'] as String? ?? '',
      orderPhotos: List<String>.from(json['orderPhotos'] ?? const []),
      confirmedAt: (json['confirmedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'courierComment': courierComment,
      'orderPhotos': orderPhotos,
      'confirmedAt': Timestamp.fromDate(confirmedAt),
    };
  }
}
