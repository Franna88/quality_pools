import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/pooIInfo.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class BluePageLayout extends StatefulWidget {
  final Function() onTap;
  final String buttonText;
  final List<Widget> pageContents;
  const BluePageLayout(
      {super.key,
      required this.pageContents,
      required this.onTap,
      required this.buttonText});

  @override
  State<BluePageLayout> createState() => _BluePageLayoutState();
}

class _BluePageLayoutState extends State<BluePageLayout> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: MyUtility(context).height,
        width: MyUtility(context).width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFF1A8CF0),
              Color(0XFF095BB2),
              Color(0xFF002A6A),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              // QualityPoolHeader takes 1/4 of the page height
              SizedBox(
                height: screenHeight / 4,
                child: QualityPoolHeader(),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pageContents,
                  ),
                ),
              ),
              CommonButton(
                  buttonText: widget.buttonText, onPressed: widget.onTap),
              SizedBox(height: MyUtility(context).height * 0.02)
            ],
          ),
        ),
      ),
    );
  }
}
