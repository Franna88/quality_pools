import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText; // Defined labelText directly in this file
  final String? Function(String?)? validator; // For validation
  final String imagePath; // Path to the image for the profile (required)

  const ReusableTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    required this.labelText,
    required this.imagePath, // Now required
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
        // Label text (header)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            labelText,
            style: QualityPoolTextstyle(context).bodyText,
          ),
        ),
        // Stack to position the icon over the underline
        Stack(
          children: [
            // TextFormField with white underline
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(
                color: Colors.white, // White text color
              ),
              validator: (value) {
                // Use custom validators based on the labelText
                if (labelText == 'Email') {
                  return emailValidator(value);
                } else if (labelText == 'Password') {
                  return passwordValidator(value);
                }
                return validator?.call(value); // Default validation
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: QualityPoolTextstyle(context).smallText.copyWith(
                      color: const Color.fromARGB(150, 148, 185,
                          207), // Adjusted alpha for transparency
                      fontWeight: FontWeight.w900,
                    ),

                filled: false, // No background color
                border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // White line border
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // White line border
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // White line border when focused
                ),
              ),
            ),
            // Icon (Image) on top of the underline
            Positioned(
              right: 0, // Position the image on the right
              bottom: 0, // Align it to the bottom of the TextField
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 4.0), // Adjust the bottom padding to align it well
                child: Image.asset(
                  imagePath,
                  width: 24.0, // Adjust the width of the image
                  height: 24.0, // Adjust the height of the image
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
