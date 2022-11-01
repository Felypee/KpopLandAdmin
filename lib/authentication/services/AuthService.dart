import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in/authentication/models/User.dart';
import 'package:sign_in/common/httpReponses/HttpResponses.dart';

final authServiceProvider = Provider((ref) {
  return AuthService();
});

class AuthService {
  Stream<User?> get authStateChange => FirebaseAuth.instance.authStateChanges();
  Future<CustomHttpResponse> logIn(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint("Result $result");
      UserModel user = UserModel(name: result.user!.displayName ?? "admin.");
      return CustomHttpResponse.success(data: user);
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        return CustomHttpResponse.failure(message: "Datos incorrectos");
      }
      if (error.code == "wrong-password") {
        return CustomHttpResponse.failure(message: "Datos incorrectos");
      }
      if (error.code == "invalid-email") {
        return CustomHttpResponse.failure(message: "Email inválido");
      }

      return CustomHttpResponse.failure(message: "Error desconocido");
    }
  }

  Future<CustomHttpResponse> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return CustomHttpResponse.success(data: null);
    } on FirebaseAuthException catch (error) {
      return CustomHttpResponse.failure(message: "Error desconocido: $error");
    }
  }
}
