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
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int currentStep = 0; // 0: sentOTP, 1: enterOTP, 2: enterNewPassword

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
              const Color(0XFF1A8CF0),
              const Color(0XFF095BB2),
              const Color(0xFF002A6A),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.08),
            const QualityPoolHeader(),
            SizedBox(height: screenHeight * 0.1),
            Text(
              'Reset Password',
              style: QualityPoolTextstyle(context).whiteStyleBody,
            ),
            SizedBox(height: screenHeight * 0.05),

            // Sent OTP Step
            Visibility(
              visible: currentStep == 0,
              child: Column(
                children: [
                  Text(
                    'Please enter phone number to receive OTP',
                    style: QualityPoolTextstyle(context).whitebodyText,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Form(
                      key: _formKey,
                      child: ReusableTextField(
                        hintText: 'phoneNumber',
                        controller: _phoneNumberController,
                        labelText: 'Enter phone number',
                        imagePath: 'images/password.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Enter OTP Step
            Visibility(
              visible: currentStep == 1,
              child: Column(
                children: [
                  Text(
                    'A one-time pin has been sent to your email.',
                    style: QualityPoolTextstyle(context).whitebodyText,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Form(
                      key: _formKey,
                      child: ReusableTextField(
                        hintText: 'OTP',
                        controller: _OTPController,
                        labelText: 'Enter OTP',
                        imagePath: 'images/otp.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Enter New Password Step
            Visibility(
              visible: currentStep == 2,
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Form(
                      key: _formKey,
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
                            hintText: 'Confirm password',
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Continue/Confirm Button
            CommonButton(
              buttonText: currentStep == 2 ? 'Confirm' : 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    if (currentStep < 2) {
                      currentStep++;
                    } else {
                      // Handle confirmation logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Password updated successfully!')),
                      );
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
