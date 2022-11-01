import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in/authentication/models/User.dart';
import 'package:sign_in/authentication/services/AuthService.dart';
import 'package:sign_in/common/responseWidgets/Failure.dart';

final logInProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(service: ref.watch(authServiceProvider), ref: ref);
  },
);

final userProvider = StateProvider<UserModel?>((ref) => null);

final authStateChangesProvider = StreamProvider((ref) {
  final controller = ref.watch(logInProvider.notifier);
  return controller.authStateChanges;
});

class AuthController extends StateNotifier<bool> {
  AuthController({required this.service, required this.ref}) : super(false);
  final AuthService service;
  final Ref ref;

  Stream<User?> get authStateChanges => service.authStateChange;

  Future<void> logIn(
      BuildContext context, String email, String password) async {
    state = true;
    final result = await service.logIn(email, password);
    state = false;
    result.when(success: (message, data) {
      ref.watch(userProvider.notifier).update((state) => data);
    }, failure: (message) {
      showErrorMessage(context, message);
    });
  }

  Future<void> logOut(BuildContext context) async {
    state = true;
    final result = await service.logOut();
    state = false;
    result.when(success: (message, data) {
      ref.watch(userProvider.notifier).update((state) => data);
    }, failure: (message) {
      showErrorMessage(context, message);
    });
  }
}
