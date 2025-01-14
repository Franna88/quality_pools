import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/CommonComponants/reusable_containers.dart';
import 'package:quality_pools/CommonComponants/reusable_navbar.dart';
import 'package:quality_pools/HomePage/home.dart';
import 'package:quality_pools/LandingPage/landing_page.dart';
import 'package:quality_pools/Register/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Enable clean URL strategy for web apps (without # in the URL)

  WidgetsFlutterBinding.ensureInitialized();
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
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(MaterialApp(
    home: MyApp() ,
  ));
}
