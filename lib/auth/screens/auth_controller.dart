import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //This listens constantly for any auth changes eg login/logout/signup
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
              return  HomePage(user: snapshot.data!,);
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}

//This switches between login and register pages
class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: togglePages,
      );
    } else {
      return RegisterScreen(
        onTap: togglePages,
      );
    }
  }
}
