import 'package:flutter/material.dart';
import 'package:quality_pools/PoolReadingsReusables/pool_readings.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class ViewPoolCurrentReadings extends StatelessWidget {
  final String poolName;
  final String lastReadingDate;
  final String nextReadingDate;

  const ViewPoolCurrentReadings({
    super.key,
    required this.poolName,
    required this.lastReadingDate,
    required this.nextReadingDate,
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
            Container(
              width: containerWidth,
              height: secondContainerHeight,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: PoolReadings(),
            ),
            const SizedBox(height: 20),
            // Next Reading Date Container
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 1,
                    offset: Offset(0, 4),
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
                    Text('Last Reading Date',
                        style: QualityPoolTextstyle(context).blackbodyText),
                    const Spacer(),
                    Text(lastReadingDate,
                        style: QualityPoolTextstyle(context)
                            .blackbodyText
                            .copyWith(
                                color: MyColors().lightBlue,
                                fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Next Reading Date Container
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 1,
                    offset: Offset(0, 4),
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
                    Text(nextReadingDate,
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
