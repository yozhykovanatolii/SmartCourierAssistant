import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_courier_assistant/core/exception/auth/login_exception.dart';
import 'package:smart_courier_assistant/core/exception/auth/register_exception.dart';
import 'package:smart_courier_assistant/core/exception/auth/reset_password_exception.dart';

class UserAuth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (exception) {
      throw LoginException.convertFromCode(exception.code);
    } catch (_) {
      throw LoginException();
    }
  }

  Future<String> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    String userID = '';
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userID = credential.user!.uid;
    } on FirebaseAuthException catch (exception) {
      throw RegisterException(exception.code);
    } catch (_) {
      throw RegisterException();
    }
    return userID;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (exception) {
      throw ResetPasswordException(exception.code);
    } catch (_) {
      throw ResetPasswordException();
    }
  }
}
