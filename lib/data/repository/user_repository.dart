import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/user_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/storage/supabase_storage.dart';
import 'package:smart_courier_assistant/data/model/user_model.dart';
import 'package:smart_courier_assistant/data/service/camera_picker_service.dart';
import 'package:smart_courier_assistant/data/service/native_service.dart';

class UserRepository {
  final UserAuth _userAuth = UserAuth();
  final UserFirestore _userFirestore = UserFirestore();
  final SupabaseStorage _supabaseStorage = SupabaseStorage();

  Future<bool> checkIfUserExistByEmail(String email) async {
    return _userFirestore.checkUserByEmail(email);
  }

  Future<String> getUserImage() async {
    final userImageFile = await CameraPickerService.pickImageFileFromGallery();
    final userImageUrl = await _supabaseStorage.saveImage(
      userImageFile,
      'users',
    );
    return userImageUrl;
  }

  Future<void> updateUserData(
    String userAvatar,
    String fullName,
    String phoneNumber,
  ) async {
    final userID = _userAuth.userId;
    UserModel user = await _userFirestore.getUserModelById(userID);
    user = user.copyWith(
      id: user.id,
      email: user.email,
      password: user.password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      avatar: userAvatar,
    );
    await _userFirestore.saveUser(user);
  }

  Stream<UserModel> getUserModelCurrentData() {
    final userStream = _userAuth.user;
    return userStream.asyncMap((user) async {
      if (user == null) throw UserNotFoundException('User didn\'t find');
      final userModel = await _userFirestore.getUserModelById(user.uid);
      return userModel;
    });
  }

  Future<void> callUserDialer(String userPhoneNumber) async {
    await NativeService.openDialer(userPhoneNumber);
  }

  Future<void> messageUser(String userPhoneNumber) async {
    await NativeService.openWhatsAppChat(userPhoneNumber);
  }
}
