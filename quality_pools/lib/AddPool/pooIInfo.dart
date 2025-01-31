import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/augement_measure_pool.dart';
import 'package:quality_pools/CommonComponants/blue_page_layout.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class AddPoolInfo extends StatelessWidget {
  const AddPoolInfo({super.key});

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
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableTextField(
                hintText: 'Name',
                controller: _poolName,
                labelText: 'Pool Name',
                imagePath: 'images/pen.png',
              ),
              SizedBox(height: 20),
              ReusableTextField(
                hintText: '2m',
                controller: _lowestDepth,
                labelText: 'Lowest Depth',
                imagePath: 'images/pen.png',
              ),
              SizedBox(height: 20),
              ReusableTextField(
                hintText: '5m',
                controller: _highestDepth,
                labelText: 'Highest Depth',
                imagePath: 'images/pen.png',
              ),
            ],
          ),
        ),
      ],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AugementMeasurePool(),
          ),
        );
      },
      buttonText: 'Continue',
    );
  }
}
