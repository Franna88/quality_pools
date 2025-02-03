import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0), // This controls the circle size
      decoration: BoxDecoration(
        color: Colors.transparent, // Make the circle transparent
        shape: BoxShape.circle, // Make the container circular
        border: Border.all(
          color: MyColors().mediumBlue, // Light blue border color
          width: 2.0, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Center(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors().mediumBlue, // Set icon color to light blue
            ),
            onPressed: () {
              Navigator.pop(context); // This will navigate back one page
            },
            iconSize: 30.0, // Adjust the icon size if needed
          ),
        ),
      ),
    );
  }
}
