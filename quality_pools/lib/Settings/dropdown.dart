import 'package:flutter/material.dart';

class ReusableDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hintText;
  final Function(String?) onChanged;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;

  const ReusableDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? Colors.grey,
          width: 1.0,
        ),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        hint: Text(hintText),
        isExpanded: true,
        underline: const SizedBox(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
