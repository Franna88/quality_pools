import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? customWidth;

  const CommonButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.customWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: customWidth ?? screenWidth * 0.6,
      decoration: BoxDecoration(
        color: const Color(0XFF1A8CF0),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 4), // Bottom shadow
          ),
        ],
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors
              .transparent, // Set transparent to avoid overriding the container color
          minimumSize: const Size(200, 45),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: 'Judson',
          ),
        ),
      ),
    );
  }
}
