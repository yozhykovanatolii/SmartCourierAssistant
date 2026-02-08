import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class RouteModel {
  final String routeId;
  final String courierId;
  final DateTime date;
  final String recommendation;

  RouteModel({
    required this.routeId,
    required this.courierId,
    required this.date,
    required this.recommendation,
  });

  factory RouteModel.initial() {
    return RouteModel(
      routeId: const Uuid().v1(),
      courierId: '',
      recommendation: '',
      date: DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'routeId': routeId,
      'courierId': courierId,
      'date': Timestamp.fromDate(date),
      'recommendation': recommendation,
    };
  }

  factory RouteModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RouteModel(
      routeId: data?['routeId'] as String,
      courierId: data?['courierId'] as String,
      date: (data?['date'] as Timestamp).toDate(),
      recommendation: data?['recommendation'] as String,
    );
  }

  RouteModel copyWith({
    String? routeId,
    String? courierId,
    DateTime? date,
    String? recommendation,
  }) {
    return RouteModel(
      routeId: routeId ?? this.routeId,
      courierId: courierId ?? this.courierId,
      date: date ?? this.date,
      recommendation: recommendation ?? this.recommendation,
    );
  }
}
