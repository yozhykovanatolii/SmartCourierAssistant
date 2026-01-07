import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/data/datasource/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/firestore/user_firestore.dart';
import 'package:smart_courier_assistant/data/model/user_model.dart';

class UserRepository {
  final UserAuth _userAuth = UserAuth();
  final UserFirestore _userFirestore = UserFirestore();

  Future<bool> checkIfUserExistByEmail(String email) async {
    return _userFirestore.checkUserByEmail(email);
  }

  Stream<UserModel> getUserModelCurrentData() {
    final userStream = _userAuth.user;
    return userStream.asyncMap((user) async {
      if (user == null) throw UserNotFoundException('User didn\'t find');
      final userModel = await _userFirestore.getUserModelById(user.uid);
      return userModel;
    });
  }
}
