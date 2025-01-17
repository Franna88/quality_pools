import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class BlueReadingsContainer extends StatelessWidget {
  final String readingType;
  final String readingMeasurement = '5';
  const BlueReadingsContainer({
    Key? key,
    required this.readingType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the size of the square as a percentage of the screen's width
        double size =
            constraints.maxWidth * 0.26; // Adjust 0.5 as needed for size ratio

        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0XFF1A8CF0),
                  Color(0XFF095BB2),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.shade400,
              //     blurRadius: 1,
              //     offset: Offset(0, 4),
              //   ),
              // ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      readingType,
                      style: QualityPoolTextstyle(context).readingType,
                    ),
                    Text(readingMeasurement,
                        style: QualityPoolTextstyle(context)
                            .blackSubheaderText
                            .copyWith(
                                color: const Color.fromARGB(255, 76, 219, 81),
                                fontWeight: FontWeight.bold)),
                    Text('ppm',
                        style: QualityPoolTextstyle(context).whitebodyText),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
