import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/LandingPage/landing_page.dart';
import 'package:quality_pools/MyPools/PoolNotes/pool_notes.dart';
import 'package:quality_pools/MyPools/TestPool/test_pool.dart';
import 'package:quality_pools/Register/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quality_pools/Services/service_status_screen.dart';

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
      await Firebase.initializeApp();
    }
    print("Firebase initialized successfully");
    firebaseInitialized = true;
  } catch (e) {
    print("Error initializing Firebase: $e");
    // Continue with app launch even if Firebase initialization fails
  }

  // Properly structure the MaterialApp
  runApp(MyApp(firebaseInitialized: firebaseInitialized));
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
