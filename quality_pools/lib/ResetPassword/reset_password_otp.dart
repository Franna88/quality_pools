import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class ResetPasswordOTP extends StatefulWidget {
  const ResetPasswordOTP({super.key});

  @override
  State<ResetPasswordOTP> createState() => _ResetPasswordOTPState();
}

class _ResetPasswordOTPState extends State<ResetPasswordOTP> {
  final TextEditingController _OTPController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showOTPForm = true; // Controls which Visibility widget is shown
  bool isPasswordCreated =
      false; // Tracks if the password is successfully created

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            SizedBox(height: screenHeight * 0.08),
            QualityPoolHeader(),
            SizedBox(height: screenHeight * 0.1),
            Text(
              'Reset Password',
              style: QualityPoolTextstyle(context).subHeaderStyle,
            ),
            SizedBox(height: screenHeight * 0.05),
            Visibility(
              visible: showOTPForm, // Controlled by the boolean state
              child: SizedBox(
                child: Column(
                  children: [
                    Text(
                      'A one time pin has been sent to your email.',
                      style: QualityPoolTextstyle(context).bodyText,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Form(
                        key: _formKey, // Attach the global key
                        child: Column(
                          children: [
                            ReusableTextField(
                              hintText: 'OTP',
                              controller: _OTPController,
                              labelText: 'Enter OTP',
                              imagePath: 'images/otp.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !showOTPForm, // Controlled by the boolean state
              child: SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Form(
                        key: _formKey, // Attach the global key
                        child: Column(
                          children: [
                            ReusableTextField(
                              hintText: 'Enter password',
                              controller: _passwordController,
                              labelText: 'New Password',
                              imagePath: 'images/password.png',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReusableTextField(
                              hintText: 'Enter password',
                              controller: _confirmPasswordController,
                              labelText: 'Confirm Password',
                              imagePath: 'images/password.png',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            if (isPasswordCreated)
                              Text(
                                'Password Created',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            SizedBox(height: screenHeight * 0.05),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CommonButton(
              buttonText: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    if (showOTPForm) {
                      showOTPForm = false; // Switch to password form
                    } else {
                      isPasswordCreated = true; // Mark password as created
                    }
                  });
                }
              },
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
