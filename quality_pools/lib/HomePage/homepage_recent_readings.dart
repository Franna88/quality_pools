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
    double secondContainerWidth = MediaQuery.of(context).size.width - 20;

    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: secondContainerWidth / 2,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0XFF1A8CF0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(poolName,
                        style: QualityPoolTextstyle(context).whiteStyleBody),
                  ],
                ),
              ),
            ),
            Container(
              width: secondContainerWidth,
              height: MediaQuery.of(context).size.height * 0.3,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PoolReadings(),
              ),
            ),
            const SizedBox(height: 30),
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
              width: secondContainerWidth,
              height: MediaQuery.of(context).size.height * 0.07,
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
