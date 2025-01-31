import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/blue_page_layout.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/pooIInfo.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class AddPoolImage extends StatefulWidget {
  const AddPoolImage({super.key});

  @override
  State<AddPoolImage> createState() => _AddPoolImageState();
}

class _AddPoolImageState extends State<AddPoolImage> {
  @override
  Widget build(BuildContext context) {
    return BluePageLayout(
      pageContents: [
        Text(
          'Add Pool',
          style: QualityPoolTextstyle(context).whiteStyleBody,
        ),
        InkWell(
          onTap: () {
            // Add functionality when tapped
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors().lightBlue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: MyColors().lightBlue, width: 2),
                ),
              ),
            ),
          ),
        ),
        CommonButton(
          buttonText: 'Select Image',
          onPressed: () {
            // Add functionality here
          },
        ),
      ],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddPoolInfo(),
          ),
        );
      },
      buttonText: 'Continue',
    );
  }
}
