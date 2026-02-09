import 'package:smart_courier_assistant/domain/entity/user_entity.dart';

abstract interface class UserRepository {
  Future<bool> checkIfUserExistByEmail(String email);
  Future<String> getUserImage();
  Future<void> updateUserData(UserEntity userEntity);
  Stream<UserEntity> getUserModelCurrentData();
  Future<void> callUserDialer(String userPhoneNumber);
  Future<void> messageUser(String userPhoneNumber);
}
