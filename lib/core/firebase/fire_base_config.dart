import 'dart:developer';

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

  // @lazySingleton
  // FirebaseAdminApp get firebaseAdmin {
  //   final privateKey = Platform.environment['FIREBASE_PRIVATE_KEY'];
  //   if (privateKey == null) {
  //     throw Exception('FIREBASE_PRIVATE_KEY не установлен!');
  //   }
  //   return FirebaseAdminApp.initializeApp(
  //     firebaseProjectId,
  //     Credential.fromServiceAccountParams(
  //       clientId: firebaseClientId,
  //       email: firebaseClientEmail,
  //       privateKey: privateKey.replaceAll(r'\n', '\n'),
  //     ),
  //   );
  // }

  @lazySingleton
  FirebaseAuth firebaseAuth(FirebaseApp app) =>
      FirebaseAuth.instanceFor(app: app);
}
