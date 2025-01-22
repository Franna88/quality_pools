import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/addpool_results.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/pooIInfo.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';



class AddpoolInstructions extends StatefulWidget {
  const AddpoolInstructions({super.key});

  @override
  State<AddpoolInstructions> createState() => _AddPoolImageState();
}

class _AddPoolImageState extends State<AddpoolInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFF1A8CF0),
              Color(0XFF095BB2),
              Color(0xFF002A6A),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QualityPoolHeader(),
            Text('How to Use Augmented Measuring',
             style: TextStyle(
              color: Colors.white,
             ),
             ),
            Text('Align the Camera: Open the Augmented Measuring tool and point your camera at the pool area.',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
            Text('Set Measurement Points: Tap the screen to mark the corners or edges of your pool.',
            style: TextStyle(
              color: Colors.white,
            ),),
            Text('Move Around the Pool: Walk around to capture all sides accurately, following the apps on-screen guidance.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
                SizedBox(height: 20), // Add spacing between text and buttons
                CommonButton(
              buttonText: 'Start',
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPoolInfo(),
                    ),);
              },
            ),
             SizedBox(height: 50), // Add spacing between text and buttons
                            CommonButton(
              buttonText: 'Continue',
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddpoolResults(),
                    ),);
              },
            ),
          
            
            
          ],
        ),
      ),
    );
  }
}
