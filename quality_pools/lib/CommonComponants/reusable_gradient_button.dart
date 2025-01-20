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
        height: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF1A8CF0),
              Color(0XFF095BB2),
            ],
          ),
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
            style: QualityPoolTextstyle(context).whiteStyleBody,
          ),
        ),
      ),
    );
  }
}
