import 'package:csp_project_app/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the User and AuthService from providers
    final authService = context.read<AuthService>();
    final user = context.watch<User?>();

    // Handle user being null (though AuthWrapper should prevent this)
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Not logged in"),
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),

            // Display user's name or a placeholder
            Text(
              user.displayName ?? "User Profile",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Display user's email
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 1.5),
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent.withAlpha(50),
              ),
              child: Row(
                children: [
                  const Icon(Icons.mail, color: Colors.blueAccent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user.email ?? "No email associated",
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🚪 Functional Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Call the signOut method
                  authService.signOut();
                  // AuthWrapper will handle navigation
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white, // Ensure text is white
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}