import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/HomePage/home_page.dart';
import 'package:quality_pools/ResetPassword/reset_password_otp.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    void _signIn() async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("User signed in: ${userCredential.user?.uid}");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        print("Error signing in: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }

    // GlobalKey for form validation
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFF1A8CF0),
              Color(0XFF095BB2),
              Color(0xFF002A6A),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            QualityPoolHeader(),
            Spacer(),
            // Wrap the fields in a Form widget
            SizedBox(
              width: screenWidth * 0.8,
              child: Form(
                key: _formKey, // Attach the global key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ReusableTextField(
                      hintText: 'Enter Email',
                      controller: _emailController,
                      labelText: 'Email',
                      imagePath: 'images/email.png',
                      validator: (value) {
                        // Validate email on form submission
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        // Simple email regex validation
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ReusableTextField(
                      hintText: 'Enter Password',
                      controller: _passwordController,
                      labelText: 'Password',
                      imagePath: 'images/password.png',
                      obscureText: true,
                      validator: (value) {
                        // Validate password on form submission
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordOTP(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: QualityPoolTextstyle(context).whitebodyText,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            // Validate the form when the button is pressed
            CommonButton(
              buttonText: 'Login',
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // If the form is valid, proceed with login logic
                  _signIn();
                  print("Login is valid, proceed with login");
                  // Implement your login logic here (e.g., Firebase authentication)
                } else {
                  print("Form is not valid");
                }
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
