class AddressEntity {
  final String name;
  final double latitude;
  final double longitude;

  AddressEntity({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory AddressEntity.initial() {
    return AddressEntity(
      name: '',
      latitude: 0,
      longitude: 0,
    );
  }

  AddressEntity copyWith({
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return AddressEntity(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
