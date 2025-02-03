import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QualityPoolTextstyle {
  final BuildContext context;
  QualityPoolTextstyle(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get textScale => MediaQuery.of(context).textScaleFactor;

  double responsiveSize(double baseSize) {
    return (width / baseSize).clamp(12.0, 60.0) * textScale;
  }

  // Header Styles
  TextStyle get header1 => GoogleFonts.judson(
        fontSize: responsiveSize(2),
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get header2 => GoogleFonts.judson(
        fontSize: responsiveSize(4),
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get pageTitle => GoogleFonts.judson(
        fontSize: responsiveSize(14),
        fontWeight: FontWeight.w800,
        color: Colors.black,
        shadows: [
          Shadow(
            offset: const Offset(2.0, 2.0),
            blurRadius: 4.0,
            color: Colors.grey.shade400,
          ),
        ],
      );

  TextStyle get readingType => GoogleFonts.nunito(
        fontSize: responsiveSize(24),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  // Body Text Styles
  TextStyle get whitebodyText => GoogleFonts.nunito(
        fontSize: responsiveSize(26),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  TextStyle get blackSubheaderText => GoogleFonts.nunito(
        fontSize: responsiveSize(20),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  TextStyle get blackStyleMedium => GoogleFonts.judson(
        fontSize: responsiveSize(20),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  TextStyle get blackbodyText => GoogleFonts.nunito(
        fontSize: responsiveSize(26),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  TextStyle get blackStyleBody => GoogleFonts.judson(
        fontSize: responsiveSize(26),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  TextStyle get whiteStyleBody => GoogleFonts.judson(
        fontSize: responsiveSize(18),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  TextStyle get smallText => GoogleFonts.nunito(
        fontSize: responsiveSize(34),
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
      fontSize: responsiveSize(fontSize),
      fontWeight: fontWeight,
      color: color,
    );
  }
}
