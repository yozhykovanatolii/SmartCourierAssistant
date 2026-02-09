import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/user_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/storage/supabase_storage.dart';
import 'package:smart_courier_assistant/data/mapper/user_mapper.dart';
import 'package:smart_courier_assistant/data/model/firestore/user_model.dart';
import 'package:smart_courier_assistant/data/service/camera_picker_service.dart';
import 'package:smart_courier_assistant/data/service/native_service.dart';
import 'package:smart_courier_assistant/domain/entity/user_entity.dart';
import 'package:smart_courier_assistant/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserAuth userAuth;
  final UserFirestore userFirestore;
  final SupabaseStorage supabaseStorage;

  UserRepositoryImpl(this.userAuth, this.userFirestore, this.supabaseStorage);

  @override
  Future<bool> checkIfUserExistByEmail(String email) async {
    return userFirestore.checkUserByEmail(email);
  }

  @override
  Future<String> getUserImage() async {
    final userImageFile = await CameraPickerService.pickImageFileFromGallery();
    final userImageUrl = await supabaseStorage.saveImage(
      userImageFile,
      'users',
    );
    return userImageUrl;
  }

  @override
  Future<void> updateUserData(
    UserEntity userEntity,
  ) async {
    final userID = userAuth.userId;
    UserModel user = await userFirestore.getUserModelById(userID);
    user = user.copyWith(
      id: user.id,
      email: user.email,
      password: user.password,
      fullName: userEntity.fullName,
      phoneNumber: userEntity.phoneNumber,
      avatar: userEntity.avatar,
    );
    await userFirestore.saveUser(user);
  }

  @override
  Stream<UserEntity> getUserModelCurrentData() {
    final userStream = userAuth.user;
    return userStream.asyncMap((user) async {
      if (user == null) throw UserNotFoundException('User didn\'t find');
      final userModel = await userFirestore.getUserModelById(user.uid);
      return UserMapper.toEntity(userModel);
    });
  }

  @override
  Future<void> callUserDialer(String userPhoneNumber) async {
    await NativeService.openExtrenal('openDialer', userPhoneNumber);
  }

  @override
  Future<void> messageUser(String userPhoneNumber) async {
    await NativeService.openExtrenal('openWhatsAppChat', userPhoneNumber);
  }
}
