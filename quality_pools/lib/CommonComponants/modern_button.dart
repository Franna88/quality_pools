import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/modern_theme.dart';

class ModernButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final bool isLoading;
  final double? height;
  final double? width;
  final EdgeInsets? margin;

  const ModernButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.isLoading = false,
    this.height,
    this.width,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      width: width,
      child: ElevatedButton(
        style: isSecondary
            ? ModernTheme.secondaryButtonStyle(height: height)
            : ModernTheme.primaryButtonStyle(height: height),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isSecondary
                      ? ModernTheme.textDark
                      : ModernTheme.textLight,
                ),
              )
            : Text(
                text,
                style: ModernTheme.buttonStyle(),
              ),
      ),
    );
  }
}

class ModernTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? style;

  const ModernTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ModernTheme.textButtonStyle(),
      onPressed: onPressed,
      child: Text(
        text,
        style: style ??
            ModernTheme.bodyStyle(
              fontWeight: FontWeight.w600,
              color: ModernTheme.navyBlue,
            ),
      ),
    );
  }
}
