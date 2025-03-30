import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

const users = 'users';
const uuid = 'uuid';

abstract interface class ProfileDataSource {
  Future<void> saveUserData(Map<String, dynamic> userData);
}

@Singleton(as: ProfileDataSource)
final class FirebaseProfileDataSource implements ProfileDataSource {
  final FirebaseFirestore _firestore;

  FirebaseProfileDataSource(this._firestore);
  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final userDoc = _firestore.collection(users).doc(userData[uuid]);
    await userDoc.set(userData);
  }
}
