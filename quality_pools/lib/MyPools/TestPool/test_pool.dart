import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/back_button.dart';
import 'package:quality_pools/CommonComponants/blue_page_layout.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/MyPools/TestPool/test_results.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class TestPool extends StatelessWidget {
  const TestPool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BluePageLayout(
            pageContents: [
              Text(
                'Upload an image of the pool test strip',
                style: QualityPoolTextstyle(context).whiteStyleBody,
                textAlign: TextAlign.center,
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
                        border:
                            Border.all(color: MyColors().lightBlue, width: 2),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Container(
                            child: Icon(
                              Icons.add,
                              color: MyColors().lightBlue, // Set icon color
                            ),
                          ),
                          onPressed: () {
                            // Add functionality when the plus button is pressed
                          },
                          iconSize: 60.0, // Adjust the size of the plus icon
                        ),
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
                MaterialPageRoute(builder: (context) => TestResults()),
              );
            },
            buttonText: 'Continue',
          ),
          Positioned(
              top: 30.0, // Adjust this for vertical positioning
              left: 16.0, // Adjust this for horizontal positioning
              child: CustomBackButton()),
        ],
      ),
    );
  }
}
