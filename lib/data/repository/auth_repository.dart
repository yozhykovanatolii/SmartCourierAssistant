import 'package:smart_courier_assistant/data/datasource/firebase_auth/user_auth.dart';

class AuthRepository {
  final UserAuth _userAuth = UserAuth();

  Future<void> signInUser(String email, String password) async {
    await _userAuth.signInWithEmailAndPassword(email, password);
  }
}
