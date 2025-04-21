import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class BlueReadingsContainer extends StatelessWidget {
  final String readingType;
  final String readingMeasurement = '5'; // Static measurement

  const BlueReadingsContainer({
    Key? key,
    required this.readingType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MyUtility(context).width * 0.22;

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
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  readingType,
                  style: QualityPoolTextstyle(context).readingType,
                ),
                Text(
                  readingMeasurement,
                  style: QualityPoolTextstyle(context).readingType.copyWith(
                        color: const Color.fromARGB(255, 76, 219, 81),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'ppm',
                  style: QualityPoolTextstyle(context).whitebodyText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//  Text(
//                   readingType,
//                   style: QualityPoolTextstyle(context).readingType,
//                 ),
//                 Text(
//                   readingMeasurement,
//                   style: QualityPoolTextstyle(context).readingType.copyWith(
//                         color: const Color.fromARGB(255, 76, 219, 81),
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 Text(
//                   'ppm',
//                   style: QualityPoolTextstyle(context).whitebodyText,
//                 ),
