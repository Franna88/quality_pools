import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/blue_page_layout.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class AugementMeasureResults extends StatelessWidget {
  final String results = '80';
  const AugementMeasureResults({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _poolName = TextEditingController();
    final TextEditingController _lowestDepth = TextEditingController();
    final TextEditingController _highestDepth = TextEditingController();

    // GlobalKey for form validation
    final _formKey = GlobalKey<FormState>();

    return BluePageLayout(
      pageContents: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Add Pool',
            style: QualityPoolTextstyle(context).whiteStyleBody,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Augmented Measuring Results',
            style: QualityPoolTextstyle(context).whiteStyleBody,
          ),
        ),
        Image.asset(
          'images/augement_pool_image.png',
          width: MyUtility(context).width * 0.8,
          height: MyUtility(context).height * 0.3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RichText(
            text: TextSpan(
              style: QualityPoolTextstyle(context).header1,
              children: [
                TextSpan(
                  text: '$results ', // The result value
                ),
                TextSpan(
                  text: 'm',
                  style: TextStyle(
                      fontSize: QualityPoolTextstyle(context)
                          .header1
                          .fontSize), // Ensures the m size matches the rest of the text
                ),
                TextSpan(
                  text: '³',
                  style: TextStyle(
                      fontSize: QualityPoolTextstyle(context).header1.fontSize,
                      height: 0.5), // Smaller size for superscript
                ),
              ],
            ),
          ),
        ),
      ],
      onTap: () {},
      buttonText: 'Continue',
    );
  }
}
