import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class RecentReadings extends StatelessWidget {
  const RecentReadings({super.key});

  @override
  Widget build(BuildContext context) {
    double secondContainerWidth = MediaQuery.of(context).size.width - 80;

    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First container with border radius on the top 2 corners
            Container(
              width: secondContainerWidth / 2,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0XFF1A8CF0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Pool 1',
                        style: QualityPoolTextstyle(context).whiteStyleBody),
                  ],
                ),
              ),
            ),
            // Second container with border radius on all corners except the top left
            Container(
              width: secondContainerWidth,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(child: Text('Recent Readings')),
            ),
          ],
        ),
      ),
    );
  }
}
