import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/navbar.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class MainPageLayout extends StatelessWidget {
  final Widget bodyContent;

  const MainPageLayout({
    required this.bodyContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('-QP-', style: QualityPoolTextstyle(context).header2),
                  Spacer(),
                  Navbar(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32),
                  child:
                      bodyContent, // This will be the content passed to the layout
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
