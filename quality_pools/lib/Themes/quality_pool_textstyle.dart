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

  TextStyle get pageTitle => GoogleFonts.judson(
        fontSize: width / 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        shadows: [
          Shadow(
            offset: Offset(2.0, 2.0), // Horizontal and vertical offset
            blurRadius: 3.0, // Blur radius
            color: Colors.grey, // Shadow color
          ),
        ],
      );

  TextStyle get readingType => GoogleFonts.nunito(
        fontSize: width / 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  // Body Text Styles
  TextStyle get whitebodyText => GoogleFonts.nunito(
        fontSize: width / 26,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  TextStyle get blackSubheaderText => GoogleFonts.nunito(
        fontSize: width / 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  TextStyle get blackStyleMedium => GoogleFonts.judson(
        fontSize: width / 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  TextStyle get blackbodyText => GoogleFonts.nunito(
        fontSize: width / 26,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  TextStyle get blackStyleBody => GoogleFonts.judson(
        fontSize: width / 26,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  // Body Text Styles
  TextStyle get whiteStyleBody => GoogleFonts.judson(
        fontSize: width / 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  TextStyle get smallText => GoogleFonts.nunito(
        fontSize: width / 34,
        fontWeight: FontWeight.normal,
        color: Colors.white,
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
