import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final String? Function(String?)? validator;
  final String imagePath;

  const ReusableTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    required this.labelText,
    required this.imagePath,
  }) : super(key: key);

  // Email validator
  String? emailValidator(String? value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validator
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label text
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            labelText,
            style: QualityPoolTextstyle(context).whitebodyText,
          ),
        ),
        // TextFormField with white underline
        Stack(
          children: [
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(
                color: Colors.white, // White text color
              ),
              validator: (value) {
                // Use specific validators based on labelText
                if (labelText == 'Email') {
                  return emailValidator(value);
                } else if (labelText == 'Password' ||
                    labelText == 'Confirm Password') {
                  return passwordValidator(value);
                }
                return validator?.call(value); // Default validation
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: QualityPoolTextstyle(context).smallText.copyWith(
                      color: MyColors().darkBlue,
                      fontWeight: FontWeight.w900,
                    ),
                filled: false,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            // Icon (Image) on top of the underline
            Positioned(
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  imagePath,
                  width: 24.0,
                  height: 24.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
