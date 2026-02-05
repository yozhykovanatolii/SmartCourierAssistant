class UserEntity {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String avatar;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.avatar,
  });

  factory UserEntity.initial() {
    return UserEntity(
      id: '',
      fullName: '',
      phoneNumber: '',
      avatar: '',
    );
  }

  UserEntity copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? avatar,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
    );
  }
}
