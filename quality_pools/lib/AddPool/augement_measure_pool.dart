import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/augement_measure_results.dart';
import 'package:quality_pools/CommonComponants/blue_page_layout.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class AugementMeasurePool extends StatelessWidget {
  const AugementMeasurePool({super.key});

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
        Align(
          alignment: Alignment.centerLeft, // Align text to the left
          child: RichText(
            textAlign:
                TextAlign.left, // Ensures left alignment within the container
            text: TextSpan(
              style: QualityPoolTextstyle(context).whitebodyText,
              children: const [
                TextSpan(
                  text: 'How to Use Augmented Measuring\n\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '1. Align the Camera: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Open the Augmented Measuring tool and point your camera at the pool area.\n\n',
                ),
                TextSpan(
                  text: '2. Set Measurement Points: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Tap the screen to mark the corners or edges of your pool.\n\n',
                ),
                TextSpan(
                  text: '3. Move Around the Pool: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Walk around to capture all sides accurately, following the app\'s on-screen guidance.',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: CommonButton(
            buttonText: 'Start',
            onPressed: () {},
            customWidth: MyUtility(context).width * 0.4,
          ),
        ),
      ],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AugementMeasureResults(),
          ),
        );
      },
      buttonText: 'Continue',
    );
  }
}
