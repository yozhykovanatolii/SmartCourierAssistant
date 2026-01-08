import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_courier_assistant/data/model/user_model.dart';

class UserFirestore {
  final _firestore = FirebaseFirestore.instance;

  Future<bool> checkUserByEmail(String email) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> saveUser(UserModel userModel) async {
    final docReference = _getUserDocumentReference(userModel.id);
    await docReference.set(userModel);
  }

  Future<UserModel> getUserModelById(String id) async {
    final docRef = _getUserDocumentReference(id);
    final snapshot = await docRef.get();
    final userModel = snapshot.data()!;
    return userModel;
  }

  Future<bool> isUserExist(String id) async {
    final docRef = _getUserDocumentReference(id);
    final snapshot = await docRef.get();
    return snapshot.exists;
  }

  DocumentReference<UserModel> _getUserDocumentReference(String id) {
    return _firestore
        .collection('users')
        .doc(id)
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFirestore(),
        );
  }
}
