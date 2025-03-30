import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:trainx_app/core/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

@module
abstract class FirebaseModule {
  @preResolve
  Future<FirebaseApp> get initFirebaseApp async {
    try {
      return await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e, stackTrace) {
      log('Ошибка инициализации Firebase: $e\n$stackTrace');
      rethrow;
    }
  }

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}
