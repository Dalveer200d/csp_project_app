import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csp_project_app/data/location_data_provider.dart';
import 'package:csp_project_app/auth/auth_wrapper.dart'; // Import AuthWrapper
import 'package:csp_project_app/auth/auth_service.dart'; // Import AuthService
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csp_project_app/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        // Service for auth logic
        Provider<AuthService>(create: (_) => AuthService()),
        // Stream of auth state changes
        StreamProvider<User?>(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
        // Your existing providers
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => LocationDataProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppTheme>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.lightDark,
      // Use AuthWrapper as the home
      home: const AuthWrapper(),
    );
  }
}
