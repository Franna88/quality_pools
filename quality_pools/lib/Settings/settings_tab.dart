import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/navbar.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/main_page_layout.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      bodyContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title is now part of the bodyContent
          Container(
            width: 200,
            height: 300,
            color: Colors.purple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: QualityPoolTextstyle(context).blackbodyText,
                ),

                // Add the content specific to SettingsTab here
                Text(
                  'Your settings content goes here...',
                  style: QualityPoolTextstyle(context).blackbodyText,
                ),

                Text(
                  'Your settings content goes here...',
                  style: QualityPoolTextstyle(context).blackbodyText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
