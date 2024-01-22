import 'package:fawlpox/auth/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/submit_button.dart';
import 'forgot_passoword.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? error;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final LocalAuthentication auth;

  @override
  void initState() {
    super.initState();
  }

  final codeController = TextEditingController();
  getSmsCodeFromUser() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter SMS Code'),
          content: TextField(
            controller: codeController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(codeController.text.toString());
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Email input field
                  CustomTextField(
                    hidePassword: false,
                    controller: emailController,
                    icon: Icons.email,
                    hintText: "Email",
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
                  const SizedBox(height: 15),

                  //Password input field
                  CustomTextField(
                    hidePassword: true,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    controller: passwordController,
                    icon: Icons.lock_outline_rounded,
                    hintText: "Password",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters long";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    ),
                    child: const Center(
                      child: Text("Forgot Password?"),
                    ),
                  ),

                  //Submit button
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                        ref
                            .watch(authControllerProvider)
                            .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                      }
                    },
                    child: const SubmitButton(buttonText: "Login"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //Navigate to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New to this app?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: widget.onTap,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
