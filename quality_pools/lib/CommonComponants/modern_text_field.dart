import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/modern_theme.dart';

class ModernTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData icon;
  final bool enabled;
  final int maxLines;
  final FocusNode? focusNode;
  final EdgeInsets? margin;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  const ModernTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.focusNode,
    this.margin,
    this.textInputAction,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<ModernTextField> createState() => _ModernTextFieldState();
}

class _ModernTextFieldState extends State<ModernTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText && !_showPassword,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onSubmitted,
        style: ModernTheme.bodyStyle(),
        decoration: ModernTheme.inputDecoration(
          hintText: widget.hint,
          labelText: widget.label,
          prefixIcon: Icon(
            widget.icon,
            color: ModernTheme.navyBlue,
          ),
        ).copyWith(
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                    color: ModernTheme.navyBlue,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
