import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;

  const ProfileEntity({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  ProfileEntity copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
  }) {
    return ProfileEntity(
      uid: uid ?? this.uid,
      email: email ?? this.uid,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoURL,
      ];
}
