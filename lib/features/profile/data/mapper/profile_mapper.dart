import 'package:firebase_auth/firebase_auth.dart';
import 'package:trainx_app/features/profile/domain/entity/profile_entity.dart';

extension ProfileEntityMapper on User {
  ProfileEntity toEntity() {
    return ProfileEntity(
      uid: uid,
      email: email ?? '',
      displayName: displayName ?? '',
      photoURL: photoURL ?? '',
    );
  }
}

extension UserMapper on ProfileEntity {
  Map<String, dynamic> toFirestoreMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}
