import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernTheme {
  // Main theme colors based on Pool Stuff logo
  static const Color navyBlue = Color(0xFF002A4A); // Dark blue from POOL text
  static const Color limeGreen =
      Color(0xFFB6D433); // Bright green from STUFF text
  static const Color aquaBlue =
      Color(0xFF00A9E0); // Light blue from water droplets
  static const Color backgroundWhite = Color(0xFFF8F9FA);
  static const Color textDark = Color(0xFF1A2A36);
  static const Color textLight = Color(0xFFF8F9FA);
  static const Color errorRed = Color(0xFFE53935);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [aquaBlue, navyBlue],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [limeGreen, Color(0xFF8BA827)], // Darker shade of lime green
  );

  // Text styles
  static TextStyle headingStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: fontSize ?? 24.0,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? textDark,
    );
  }

  static TextStyle bodyStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 16.0,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? textDark,
    );
  }

  static TextStyle buttonStyle({double? fontSize}) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 16.0,
      fontWeight: FontWeight.w600,
      color: textLight,
    );
  }

  // Input decoration
  static InputDecoration inputDecoration({
    required String hintText,
    required String labelText,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      hintStyle: bodyStyle(color: Colors.grey.shade400),
      labelStyle: bodyStyle(color: navyBlue, fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: aquaBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorRed, width: 2),
      ),
    );
  }

  // Button styles
  static ButtonStyle primaryButtonStyle({double? height}) {
    return ElevatedButton.styleFrom(
      elevation: 2,
      backgroundColor: navyBlue,
      foregroundColor: textLight,
      minimumSize: Size(double.infinity, height ?? 54),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static ButtonStyle secondaryButtonStyle({double? height}) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: limeGreen,
      foregroundColor: textDark,
      minimumSize: Size(double.infinity, height ?? 54),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static ButtonStyle textButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: navyBlue,
      textStyle: bodyStyle(fontWeight: FontWeight.w600),
    );
  }
}
