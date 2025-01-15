import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/HomePage/recent_readings.dart';
import 'package:quality_pools/main_page_layout.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/navbar.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      bodyContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title is now part of the bodyContent
          Text(
            'Most Recent Readings',
            style: QualityPoolTextstyle(context).blackbodyText,
          ),
          SizedBox(height: 20),
          // Add the content specific to HomePageMain here
          RecentReadings(),
        ],
      ),
    );
  }
}
