import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/LandingPage/landing_page.dart';
import 'package:quality_pools/MyPools/PoolNotes/pool_notes.dart';
import 'package:quality_pools/MyPools/TestPool/test_pool.dart';
import 'package:quality_pools/Register/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quality_pools/Services/service_status_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  // Ensure Flutter widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with improved error handling
  bool firebaseInitialized = false;

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyASV-AWsGDfmNfGU2nJw3r25KdYMic9SUU",
            authDomain: "quality-pools-2c750.firebaseapp.com",
            projectId: "quality-pools-2c750",
            storageBucket: "quality-pools-2c750.firebasestorage.app",
            messagingSenderId: "433504568249",
            appId: "1:433504568249:web:d5bd136a487fb30f37ac68",
            measurementId: "G-CW5Q128PMS"),
      );
    } else {
      // Initialize Firebase with default options
      await Firebase.initializeApp();

      // Wait a moment for Firebase to fully initialize
      await Future.delayed(const Duration(milliseconds: 1000));

      // Set persistence to LOCAL for better compatibility
      try {
        await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      } catch (e) {
        print("Failed to set persistence: $e");
        // Continue anyway as this is not critical
      }
    }
    print("Firebase initialized successfully");
    firebaseInitialized = true;
  } catch (e) {
    print("Error initializing Firebase: $e");
    // Continue with app launch even if Firebase initialization fails
  }

  // Create a test user if in debug mode
  if (kDebugMode && firebaseInitialized) {
    await _createTestUserIfNeeded();
  }

  // Properly structure the MaterialApp
  runApp(MyApp(firebaseInitialized: firebaseInitialized));
}

// Create a test user for debugging purposes
Future<void> _createTestUserIfNeeded() async {
  const email = "test@example.com";
  const password = "password123";

  try {
    // Check if user exists
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // User exists, sign out
      await FirebaseAuth.instance.signOut();
      print("Test user exists, signed out for fresh login experience");
    } catch (e) {
      // User doesn't exist, create them
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        "id": userCredential.user!.uid,
        "email": email,
        "address": "123 Test St",
        "mobileNumber": "1234567890",
        "createdAt": FieldValue.serverTimestamp(),
      });

      await FirebaseAuth.instance.signOut();
      print("Created test user: $email with password: $password");
    }
  } catch (e) {
    print("Error setting up test user: $e");
  }
}

class MyApp extends StatelessWidget {
  final bool firebaseInitialized;

  const MyApp({super.key, required this.firebaseInitialized});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quality Pools',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
