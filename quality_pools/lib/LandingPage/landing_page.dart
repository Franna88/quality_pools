import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/Login/loginPage.dart';
import 'package:quality_pools/Register/register.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
            Spacer(),
            QualityPoolHeader(),
            Spacer(),

            CommonButton(
              buttonText: 'Login',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Loginpage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Space between the buttons
            CommonButton(
              buttonText: 'Sign Up',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
