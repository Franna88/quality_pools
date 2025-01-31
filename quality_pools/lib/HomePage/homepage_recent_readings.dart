import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_grey_results_container.dart';
import 'package:quality_pools/PoolReadingsReusables/pool_readings.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class HomePageRecentReadings extends StatelessWidget {
  final String poolName;
  final String date;

  final String nextReadingDate = 'Mon, 16 Feb';

  const HomePageRecentReadings({
    super.key,
    required this.poolName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust container width and height based on screen size
    double containerWidth = screenWidth * 0.9; // 90% of screen width

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pool Name Container
        Container(
          width: MyUtility(context).width * 0.4,
          height: screenHeight * 0.045, // 5% of screen height for scalability
          decoration: BoxDecoration(
            color: const Color(0XFF1A8CF0),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  poolName,
                  style: QualityPoolTextstyle(context).whiteStyleBody,
                )
              ],
            ),
          ),
        ),
        // Pool Readings Container
        PoolReadings(),

        const SizedBox(height: 30),
        // Next Reading Date Container

        ReusableGreyResultsContainer(
            description: 'Next Reading Date', result: nextReadingDate),
      ],
    );
  }
}
