import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/submit_button.dart';
import '../controller/auth_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, this.onTap});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _confirmPasswordContoler =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Name input field
                  CustomTextField(
                    hidePassword: false,
                    controller: nameController,
                    icon: Icons.person_outline_rounded,
                    hintText: "Name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
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
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //Confirm Password field
                  CustomTextField(
                    controller: _confirmPasswordContoler,
                    hidePassword: true,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    icon: Icons.lock_outline_rounded,
                    hintText: "Confirm Password",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //Submit button
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
                        ref
                            .watch(authControllerProvider)
                            .signUpWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context,
                              name: nameController.text.trim(),
                            );
                      }
                    },
                    child: const SubmitButton(buttonText: "Signup"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Joined us before?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onTap!();
                        },
                        child: Text(
                          "login",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 16,
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
