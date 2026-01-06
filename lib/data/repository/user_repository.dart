import 'package:smart_courier_assistant/data/datasource/firestore/user_firestore.dart';

class UserRepository {
  final UserFirestore _userFirestore = UserFirestore();

  Future<bool> checkIfUserExistByEmail(String email) async {
    return _userFirestore.checkUserByEmail(email);
  }
}
