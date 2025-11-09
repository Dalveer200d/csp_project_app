import 'package:csp_project_app/screens/login_screen.dart';
import 'package:csp_project_app/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the User object from the StreamProvider in main.dart
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      // User is logged in
      return const MainScreen();
    } else {
      // User is logged out
      return const LoginScreen();
    }
  }
}