import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_courier_assistant/core/constants/app_constant.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String avatar;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.avatar,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }

  factory UserModel.initial() {
    return UserModel(
      id: '',
      fullName: '',
      email: '',
      password: '57abcdefB#',
      phoneNumber: '',
      avatar: AppConstant.defaultAvatarUrl,
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: data?['id'] as String,
      fullName: data?['fullName'] as String,
      email: data?['email'] as String,
      password: data?['password'] as String,
      phoneNumber: data?['phoneNumber'] as String,
      avatar: data?['avatar'] as String,
    );
  }
}
