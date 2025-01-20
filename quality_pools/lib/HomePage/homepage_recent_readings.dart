import 'package:flutter/material.dart';
import 'package:quality_pools/PoolReadingsReusables/pool_readings.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class HomePageRecentReadings extends StatelessWidget {
  final String poolName;
  final String date;

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
    double containerWidth = screenWidth - 20; // Padding adjustment
    double secondContainerHeight =
        screenHeight * 0.32; // Adjust height as 30% of screen height
    double nextReadingHeight =
        screenHeight * 0.07; // Adjust height as 7% of screen height

    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pool Name Container
            Container(
              width: containerWidth / 2, // 50% of screen width
              height: screenHeight *
                  0.045, // 5% of screen height for better scalability
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
            Container(
              width: containerWidth,
              height: secondContainerHeight,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: PoolReadings(),
            ),
            const SizedBox(height: 30),
            // Next Reading Date Container
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              width: containerWidth,
              height: nextReadingHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Next Reading Date',
                        style: QualityPoolTextstyle(context).blackbodyText),
                    const Spacer(),
                    Text(date,
                        style: QualityPoolTextstyle(context)
                            .blackbodyText
                            .copyWith(
                                color: MyColors().lightBlue,
                                fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
