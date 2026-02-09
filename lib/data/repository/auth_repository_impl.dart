import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/user_firestore.dart';
import 'package:smart_courier_assistant/data/model/firestore/user_model.dart';
import 'package:smart_courier_assistant/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserAuth userAuth;
  final UserFirestore userFirestore;

  AuthRepositoryImpl(this.userAuth, this.userFirestore);

  @override
  Future<void> signInUser(String email, String password) async {
    await userAuth.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> resetPassword(String email) async {
    return await userAuth.resetPassword(email);
  }

  @override
  Future<void> signUpUser(
    String email,
    String password,
    String fullName,
    String phoneNumber,
  ) async {
    final userID = await userAuth.signUpWithEmailAndPassword(
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
    await userFirestore.saveUser(userModel);
  }

  @override
  Future<void> signInWithGoogle() async {
    final user = await userAuth.signInWithGoogle();
    final isUserExist = await userFirestore.isUserExist(user!.uid);
    UserModel userModel = UserModel.initial();
    if (!isUserExist) {
      userModel = userModel.copyWith(
        id: user.uid,
        fullName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        avatar: user.photoURL,
      );
      await userFirestore.saveUser(userModel);
    }
  }

  @override
  Future<void> logOut() async {
    await userAuth.signOut();
  }
}
