import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_courier_assistant/core/exception/auth/login_exception.dart';
import 'package:smart_courier_assistant/core/exception/auth/login_with_google_exception.dart';
import 'package:smart_courier_assistant/core/exception/auth/register_exception.dart';
import 'package:smart_courier_assistant/core/exception/auth/reset_password_exception.dart';
import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';

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
      throw RegisterException.convertFromCode(exception.code);
    } catch (_) {
      throw RegisterException();
    }
    return userID;
  }

  Future<User?> signInWithGoogle() async {
    User? user;
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '934114202056-bo1uqh0p5tqm4q3ia2qr32q13nvjlu9t.apps.googleusercontent.com',
      );
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final firebaseUser = await _firebaseAuth.signInWithCredential(credential);
      user = firebaseUser.user!;
    } on FirebaseAuthException catch (exception) {
      throw LoginWithGoogleException.convertFromCode(exception.code);
    } catch (_) {
      throw LoginWithGoogleException();
    }
    return user;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (exception) {
      throw ResetPasswordException.convertFromCode(exception.code);
    } catch (_) {
      throw ResetPasswordException();
    }
  }

  String get userId {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) throw UserNotFoundException('User didn\'t find');
    return currentUser.uid;
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
