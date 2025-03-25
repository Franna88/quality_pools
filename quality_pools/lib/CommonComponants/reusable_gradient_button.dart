import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class ReusableGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool
      useCustomGreen; // Optional flag to choose the custom green gradient

  const ReusableGradientButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.useCustomGreen = false, // Default is false for the blue gradient
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the button is disabled (empty function)
    final isDisabled = onTap.toString() == '() {}';

    // Conditional gradient based on the useCustomGreen flag
    final gradient = isDisabled
        ? LinearGradient(
            colors: [
              Colors.grey.shade400,
              Colors.grey.shade600,
            ],
          )
        : useCustomGreen
            ? LinearGradient(
                colors: [
                  Color.fromARGB(
                      255, 109, 214, 112), // Custom green gradient start
                  Color(0XFF388E3C), // Custom green gradient end
                ],
              )
            : LinearGradient(
                colors: [
                  Color(0XFF1A8CF0), // Blue gradient start
                  Color(0XFF095BB2), // Blue gradient end
                ],
              );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: QualityPoolTextstyle(context).whiteStyleBody.copyWith(
                  color: isDisabled ? Colors.grey.shade300 : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
