import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/AddPool/poolImage.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';



class AddPoolInfo extends StatelessWidget {
  const AddPoolInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _poolName = TextEditingController();
    final TextEditingController _lowestDepth= TextEditingController();
    final TextEditingController _highestDepth = TextEditingController();



    //GlobalKey for form validation
    final _formKey = GlobalKey<FormState>();

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
            SizedBox( height:30),
            QualityPoolHeader(),
           SizedBox( height:30),
              SizedBox(
                width: screenWidth * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:[
                      ReusableTextField(
                      hintText: 'Name',
                      controller: _poolName,
                      labelText: 'Pool Name',
                      imagePath: 'images/edit.png',
              
                   
                    ),
                    SizedBox(height: 20),
                    ReusableTextField(
                      hintText: '2m',
                      controller: _lowestDepth,
                      labelText: 'Lowest Depth',
                      imagePath: 'images/edit.png',
                      obscureText: true,
                 
                    ),
                    SizedBox(height: 20),
                      ReusableTextField(
                      hintText: '5m',
                      controller: _highestDepth,
                      labelText: 'Highest Depth',
                      imagePath: 'images/edit.png',
                      obscureText: true,

                    ),
        
                     SizedBox(height: 50), // Add spacing between text and buttons
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
                  
                    ]
                  )

                  ),)
            
          ],
        ),
      ),
    );
  }
}
