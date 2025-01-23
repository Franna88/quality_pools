import 'package:flutter/material.dart';
import 'package:quality_pools/AddPool/addpool_instructions.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/pooIInfo.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';



class AddPoolImage extends StatefulWidget {
  const AddPoolImage({super.key});

  @override
  State<AddPoolImage> createState() => _AddPoolImageState();
}

class _AddPoolImageState extends State<AddPoolImage> {
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
                SizedBox(height: 20), // Add spacing between text and buttons
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: const Color.fromARGB(193, 102, 164, 209).withOpacity(0.5),  
                    ),
                  
                  width: 300,
                  height: 300,
                 ),
                  SizedBox(height: 20,),
                            CommonButton(
              buttonText: 'Select Image',
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPoolInfo(),
                    ),);
              },
            ),
             SizedBox(height: 60), // Add spacing between text and buttons
                            CommonButton(
              buttonText: 'Continue',
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPoolInfo(),
                    ),);
              },
            ),
          
            
            
          ],
        ),
      ),
    );
  }
}
