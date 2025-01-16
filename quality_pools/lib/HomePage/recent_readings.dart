import 'package:flutter/material.dart';
import 'package:quality_pools/PoolReadingsReusables/blue_readings_container.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class RecentReadings extends StatelessWidget {
  final String poolName = 'Pool 1';
  const RecentReadings({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First container with border radius on the top 2 corners
            Container(
              width: MediaQuery.of(context).size.width / 2 - 40,
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
                    Text(poolName,
                        style: QualityPoolTextstyle(context).whiteStyleBody),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Second container with square blue containers
            LayoutBuilder(
              builder: (context, constraints) {
                // Calculate the size for square containers
                double containerSize = (constraints.maxWidth - 40) / 2;

                return Container(
                  width: constraints.maxWidth,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(66, 61, 61, 61),
                        offset: Offset(0, 6),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: 6,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: BlueReadingsContainer(),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
