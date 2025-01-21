import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/HomePage/home_page.dart';
import 'package:quality_pools/UserAuthentication/firebase_auth_services.dart';
import 'package:quality_pools/main_page_layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create user in Firebase Auth
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Get Auth uid
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Prepare the user data for Firestore
      var userData = {
        "id": userId,
        "address": _addressController.text,
        "mobileNumber": _phoneNumberController.text,
        // other data...
      };
      // Update Firestore data
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set(userData);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddPoolImage(),
          ),
        );
      } catch (e) {
        print("Error during registration: $e");
      }
    } else {
      // If form is not validated, just go to AddPoolImage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddPoolImage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  //GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            QualityPoolHeader(),
            SizedBox(height: 30),
            SizedBox(
              width: screenWidth * 0.8,
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ReusableTextField(
                          hintText: 'Enter Email',
                          controller: _emailController,
                          labelText: 'Email',
                          imagePath: 'images/email.png',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
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
                          hintText: 'Enter phone number',
                          controller: _phoneNumberController,
                          labelText: 'Cell Number',
                          imagePath: 'images/phone.png',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a cell number';
                            } else if (value.length < 10) {
                              return 'Cell Number must be at least 10 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ReusableTextField(
                          hintText: 'Enter home Address',
                          controller: _addressController,
                          labelText: 'Home address',
                          imagePath: 'images/address.png',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an address';
                            } else if (value.length < 10) {
                              return 'Address must be at least 10 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ReusableTextField(
                          hintText: 'Enter password',
                          controller: _passwordController,
                          labelText: 'Password',
                          imagePath: 'images/password.png',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ReusableTextField(
                          hintText: 'Confirm password',
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          imagePath: 'images/password.png',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 80),
                        CommonButton(
                          buttonText: 'Continue',
                          onPressed: _register,
                        ),
                      ])),
            )
          ],
        ),
      ),
    );
  }
}
