import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../utils/error_dialog.dart';
import '../repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
    ref: ref,
  );
});

class AuthController {
  final AuthRepository _authRepository;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  }) : _authRepository = authRepository;

  //Email/password signup - REGISTER
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
  }) async {
    final result = await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold((l) {
      Navigator.pop(context);

      showAlertDialog(context: context, message: l.message);
    }, (r) {
      navigatorKey.currentState!.pop();
    });
  }

  //Email/password signin - LOGIN
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold((l) {
      print(l);
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(l.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }, (r) => navigatorKey.currentState!.pop());
  }

  //reset password - SEND RESET LINK
  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    final result = await _authRepository.resetPassword(email: email);
    result.fold((l) {
      print(l.message);
      Navigator.pop(context);
      showAlertDialog(context: context, message: l.message);
    }, (r) {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Done'),
            content: Text("Password reset link sent to $email"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
