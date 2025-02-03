import 'package:flutter/material.dart';
import 'package:quality_pools/PoolReadingsReusables/blue_readings_container.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class ReusableResultsContainer extends StatelessWidget {
  final List<String> causes;
  final List<String> fixes;
  final String readingType;
  final String lowHigh;

  const ReusableResultsContainer({
    Key? key,
    required this.causes,
    required this.fixes,
    required this.readingType,
    required this.lowHigh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenHeight * 0.4,
        ),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade400, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlueReadingsContainer(readingType: readingType),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: QualityPoolTextstyle(context)
                            .readingType
                            .copyWith(color: Colors.black),
                        children: [
                          TextSpan(text: lowHigh),
                          const TextSpan(text: " "),
                          TextSpan(text: readingType),
                          const TextSpan(text: " Results"),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '(Free Chlorine)',
                      style: QualityPoolTextstyle(context)
                          .readingType
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Causes:',
              style: QualityPoolTextstyle(context)
                  .readingType
                  .copyWith(color: Colors.black),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: causes
                  .map((item) => Text(
                        '- $item',
                        style: QualityPoolTextstyle(context).blackbodyText,
                      ))
                  .toList(),
            ),
            const Divider(color: Colors.grey, thickness: 3),
            Text(
              'Fixes:',
              style: QualityPoolTextstyle(context)
                  .readingType
                  .copyWith(color: Colors.black),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fixes
                  .map((item) => Text(
                        '- $item',
                        style: QualityPoolTextstyle(context).blackbodyText,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
