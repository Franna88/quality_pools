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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
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
            const QualityPoolHeader(),
            const SizedBox(height: 30),
            SizedBox(
              width: screenWidth * 0.8,
              child: Column(
                children: const [
                  Text(
                    'Add Pool',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'How to Use Augmented Measuring',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _NumberedInstruction(
                    number: 1,
                    text:
                        'Align the Camera: Open the Augmented Measuring tool and point your camera at the pool area.',
                  ),
                  SizedBox(height: 10),
                  _NumberedInstruction(
                    number: 2,
                    text:
                        'Set Measurement Points: Tap the screen to mark the corners or edges of your pool.',
                  ),
                  SizedBox(height: 10),
                  _NumberedInstruction(
                    number: 3,
                    text:
                        'Move Around the Pool: Walk around to capture all sides accurately, following the app\'s on-screen guidance.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // Spacing before buttons
            CommonButton(
              buttonText: 'Start',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPoolInfo(),
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
            CommonButton(
              buttonText: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddpoolResults(),
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

class _NumberedInstruction extends StatelessWidget {
  final int number;
  final String text;

  const _NumberedInstruction({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. ',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
