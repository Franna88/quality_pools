import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/Login/loginPage.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/navbar.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/main_page_layout.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _cellPhoneNumber = TextEditingController();
    final TextEditingController _homeAddress = TextEditingController();

    //GlobalKey for form validation
    final _formKey = GlobalKey<FormState>();

    return MainPageLayout(
      bodyContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title is now part of the bodyContent
          Text(
            'Settings',
            style: QualityPoolTextstyle(context).blackbodyText,
          ),
          SizedBox(height: 20),
          // Add the content specific to SettingsTab here
          Text(
            'Your settings content goes here...',
            style: QualityPoolTextstyle(context).blackbodyText,
          ),
          Form(
                  key: _formKey,
                  child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10), 
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0XFF1A8CF0),
                        Color(0XFF095BB2),
                        Color(0xFF002A6A),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                        ),]
                        ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                          
                          ReusableTextField(
                            hintText: 'Enter Email',
                            controller: _emailController,
                            labelText: 'Email',
                            imagePath: 'images/email.png',
                            validator: (value) {
                              // Validate email on form submission
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              // Simple email regex validation
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ReusableTextField(
                            hintText: 'Enter Cell Number',
                            controller: _cellPhoneNumber,
                            labelText: 'Cell Number',
                            imagePath: 'images/call.png',
                            obscureText: true,
                            validator: (value) {
                              // Validate password on form submission
                              if (value == null || value.isEmpty) {
                                return 'Please enter a cell number';
                              } else if (value.length < 10) {
                                return 'Cell Number must be at least 10 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ReusableTextField(
                            hintText: 'Enter Address',
                            controller: _homeAddress,
                            labelText: 'Address Text',
                            imagePath: 'images/location.png',
                            obscureText: true,
                            validator: (value) {
                              // Validate password on form submission
                              if (value == null || value.isEmpty) {
                                return 'Please enter a cell number';
                              } else if (value.length < 10) {
                                return 'Cell Number must be at least 10 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 20),
                          ReusableTextField(
                            hintText: 'Enter Password',
                            controller: _passwordController,
                            labelText: 'Password',
                            imagePath: 'images/password.png',
                            obscureText: true,
                            validator: (value) {
                              // Validate password on form submission
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          
                        ]
                        ),

                  )
                  ),
                    const SizedBox(height: 70),
                     CommonButton(

                            buttonText: 'Save',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Loginpage()));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const AddPoolImage(),
                              //   ),);
                            },
                          ),
                          
        ],
        
      ),
    );
  }
}
