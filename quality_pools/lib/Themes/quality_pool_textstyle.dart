import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QualityPoolTextstyle {
  BuildContext context;
  QualityPoolTextstyle(this.context);

  double get width => MediaQuery.of(context).size.width;
  // Header Styles
  TextStyle get header1 => GoogleFonts.judson(
        fontSize: width / 6.5,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get header2 => GoogleFonts.judson(
        fontSize: width / 9,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  // Body Text Styles
  TextStyle get bodyText => TextStyle(
        fontSize: width / 30,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  // Body Text Styles
  TextStyle get subHeaderStyle => GoogleFonts.judson(
        fontSize: width / 24,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get smallText => TextStyle(
        fontSize: width / 34,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  // Caption Style
  TextStyle get caption => TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.grey,
      );

  // Custom Style Example
  TextStyle customStyle({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white,
  }) {
    return GoogleFonts.judson(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
