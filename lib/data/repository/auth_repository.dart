import 'package:smart_courier_assistant/data/datasource/firebase_auth/user_auth.dart';

class AuthRepository {
  final UserAuth userAuth = UserAuth();

  Future<void> signInUser(String email, String password) async {
    await userAuth.signInWithEmailAndPassword(email, password);
  }
}
