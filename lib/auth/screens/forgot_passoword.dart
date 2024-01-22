import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/submit_button.dart';
import '../controller/auth_controller.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "Enter the email address associated with your account"),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    RegExp regex = RegExp(r'\w+@\w+\.\w+');
                    if (value!.isEmpty) {
                      return "Please enter an email adress";
                    } else if (!regex.hasMatch(value)) {
                      return "Please enter a valid email adress";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                      ref.watch(authControllerProvider).resetPassword(
                            email: emailController.text,
                            context: context,
                          );
                    }
                  },
                  child: const SubmitButton(buttonText: "Reset password"),
                )
              ],
            ),
          ),
        ));
  }
}
