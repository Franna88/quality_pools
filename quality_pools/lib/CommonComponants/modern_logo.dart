import 'package:flutter/material.dart';

class ModernLogo extends StatelessWidget {
  final double size;
  final EdgeInsets? margin;

  const ModernLogo({
    Key? key,
    this.size = 150,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 24),
      width: size,
      height: size / 2, // Maintain aspect ratio based on image dimensions
      child: Image.asset(
        'images/qp_logo.jpeg',
        fit: BoxFit.contain,
      ),
    );
  }
}
