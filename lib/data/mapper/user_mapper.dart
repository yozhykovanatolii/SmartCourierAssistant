import 'package:smart_courier_assistant/data/model/firestore/user_model.dart';
import 'package:smart_courier_assistant/domain/entity/user_entity.dart';

class UserMapper {
  static UserEntity toEntity(UserModel userModel) {
    return UserEntity(
      id: userModel.id,
      fullName: userModel.fullName,
      phoneNumber: userModel.phoneNumber,
      avatar: userModel.avatar,
    );
  }
}
