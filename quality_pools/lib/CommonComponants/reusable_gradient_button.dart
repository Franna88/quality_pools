import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class ReusableGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ReusableGradientButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF1A8CF0),
              Color(0XFF095BB2),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: QualityPoolTextstyle(context).whiteStyleBody,
          ),
        ),
      ),
    );
  }
}
