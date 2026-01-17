import 'package:smart_courier_assistant/data/datasource/remote/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firestore/user_firestore.dart';
import 'package:smart_courier_assistant/data/model/user_model.dart';

class AuthRepository {
  final UserAuth _userAuth = UserAuth();
  final UserFirestore _userFirestore = UserFirestore();

  Future<void> signInUser(String email, String password) async {
    await _userAuth.signInWithEmailAndPassword(email, password);
  }

  Future<void> resetPassword(String email) async {
    return await _userAuth.resetPassword(email);
  }

  Future<void> signUpUser(
    String email,
    String password,
    String fullName,
    String phoneNumber,
  ) async {
    final userID = await _userAuth.signUpWithEmailAndPassword(
      email,
      password,
    );
    UserModel userModel = UserModel.initial();
    userModel = userModel.copyWith(
      id: userID,
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );
    await _userFirestore.saveUser(userModel);
  }

  Future<void> signInWithGoogle() async {
    final user = await _userAuth.signInWithGoogle();
    final isUserExist = await _userFirestore.isUserExist(user!.uid);
    UserModel userModel = UserModel.initial();
    if (!isUserExist) {
      userModel = userModel.copyWith(
        id: user.uid,
        fullName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        avatar: user.photoURL,
      );
      await _userFirestore.saveUser(userModel);
    }
  }

  Future<void> logOut() async {
    await _userAuth.signOut();
  }
}
