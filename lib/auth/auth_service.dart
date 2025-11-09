import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with Email & Password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint('Sign in with email failed: $e');
      return null;
    }
  }

  // Sign up with Email & Password
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint('Sign up with email failed: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      // Only need to sign out of Firebase now
      await _auth.signOut();
    } catch (e) {
      debugPrint('Sign out failed: $e');
    }
  }
}