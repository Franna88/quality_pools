import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/modern_button.dart';
import 'package:quality_pools/CommonComponants/modern_logo.dart';
import 'package:quality_pools/CommonComponants/modern_text_field.dart';
import 'package:quality_pools/HomePage/home_page.dart';
import 'package:quality_pools/Register/register.dart';
import 'package:quality_pools/ResetPassword/reset_password_otp.dart';
import 'package:quality_pools/Themes/modern_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Print debug info
      print(
          "Attempting to sign in with email: ${_emailController.text.trim()}");

      // Add a delay to ensure Firebase is ready
      await Future.delayed(const Duration(milliseconds: 800));

      // Clear any previous login session
      try {
        await FirebaseAuth.instance.signOut();
        print("Signed out previous session if any");
      } catch (e) {
        print("No previous session to sign out: $e");
      }

      // Use the simple email/password sign-in method with additional error handling
      print("Starting sign in process...");
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      print("Sign in successful. User ID: ${userCredential.user?.uid}");

      // Verify we actually have a user
      if (userCredential.user == null) {
        throw Exception("Authentication succeeded but no user was returned");
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Exception: ${e.code} - ${e.message}");
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email address.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many login attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password sign-in is not enabled.';
          break;
        case 'network-request-failed':
          message = 'Network error. Please check your connection.';
          break;
        case 'invalid-credential':
          message = 'The provided credential is invalid or has expired.';
          break;
        default:
          message = 'Error: ${e.message}';
      }
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      print("General Exception during login: $e");
      setState(() {
        _errorMessage = 'An error occurred. Please try again. Details: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ModernTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ModernLogo(size: 220),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome Back',
                      style: ModernTheme.headingStyle(
                        fontSize: 28,
                        color: ModernTheme.textLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: ModernTheme.bodyStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ModernTheme.errorRed),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                color: ModernTheme.errorRed),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: ModernTheme.bodyStyle(
                                    color: ModernTheme.errorRed),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ModernTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    ModernTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ModernTextButton(
                        text: 'Forgot Password?',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordOTP(),
                            ),
                          );
                        },
                        style: ModernTheme.bodyStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ModernButton(
                      text: 'Sign In',
                      onPressed: _signIn,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 16),
                    // Debug section for development
                    if (kDebugMode)
                      ModernButton(
                        text: 'Debug Firebase',
                        isSecondary: true,
                        onPressed: () async {
                          try {
                            final auth = FirebaseAuth.instance;
                            print("Firebase Auth instance: $auth");

                            // Check if Firebase is initialized
                            print(
                                "Is Firebase app initialized: ${Firebase.apps.isNotEmpty}");

                            // Test if auth methods work
                            await auth.authStateChanges().first;
                            print("Auth state changes stream is working");

                            setState(() {
                              _errorMessage =
                                  "Firebase is working correctly. Check console for details.";
                            });
                          } catch (e) {
                            print("Firebase debug error: $e");
                            setState(() {
                              _errorMessage = "Firebase error: $e";
                            });
                          }
                        },
                      ),
                    if (kDebugMode)
                      ModernTextButton(
                        text: 'Use Test User',
                        onPressed: () {
                          _emailController.text = "test@example.com";
                          _passwordController.text = "password123";
                          setState(() {
                            _errorMessage =
                                "Test user credentials filled in. Click Sign In to test.";
                          });
                        },
                      ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: ModernTheme.bodyStyle(color: Colors.white70),
                        ),
                        ModernTextButton(
                          text: 'Sign Up',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          style: ModernTheme.bodyStyle(
                            color: ModernTheme.limeGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
